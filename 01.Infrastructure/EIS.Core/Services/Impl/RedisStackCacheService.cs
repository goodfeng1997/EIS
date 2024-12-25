using System.Security.Cryptography;
using System.Text;
using EIS.Shared.Extensions;
using Microsoft.Extensions.Caching.Distributed;
using Microsoft.Extensions.Logging;
using StackExchange.Redis;

namespace EIS.Core.Services.Impl;

/// <summary>
/// Redis服务
/// </summary>
public class RedisStackCacheService : IRedisStackCacheService
{
    private readonly IDatabase _redisDatabase;
    private readonly IConnectionMultiplexer _connectionMultiplexer;
    private readonly ILogger<RedisStackCacheService> _logger;

    /// <summary>
    /// 构造函数
    /// </summary>
    /// <param name="logger"></param>
    /// <param name="connectionMultiplexer"></param>
    public RedisStackCacheService(ILogger<RedisStackCacheService> logger, IConnectionMultiplexer connectionMultiplexer)
    {
        _logger = logger;
        _connectionMultiplexer = connectionMultiplexer;
        _redisDatabase = connectionMultiplexer.GetDatabase();
    }

    #region Redis基础操作

    #region 添加缓存数据

    /// <summary>
    /// 添加缓存数据
    /// </summary>
    /// <param name="key"></param>
    /// <param name="value"></param>
    /// <param name="options"></param>
    public void Set(string key, byte[] value, DistributedCacheEntryOptions options)
    {
        var creationTime = DateTimeOffset.UtcNow;
        var absoluteExpiration = GetAbsoluteExpiration(creationTime, options);
        
        _redisDatabase.SetAdd(key, new RedisValue[]
        {
            absoluteExpiration?.Ticks ?? -1,
            options.SlidingExpiration?.Ticks ?? -1,
            GetExpirationInSeconds(creationTime, GetAbsoluteExpiration(creationTime, options), options) ?? -1,
            value
        });
    }

    /// <summary>
    /// 添加缓存数据
    /// </summary>
    /// <param name="key"></param>
    /// <param name="value"></param>
    /// <param name="options"></param>
    /// <param name="token"></param>
    /// <returns></returns>
    public async Task SetAsync(string key, byte[] value, DistributedCacheEntryOptions options,
        CancellationToken token)
    {
        var creationTime = DateTimeOffset.UtcNow;
        var absoluteExpiration = GetAbsoluteExpiration(creationTime, options);
        
        await _redisDatabase.SetAddAsync(key, new RedisValue[]
        {
            absoluteExpiration?.Ticks ?? -1,
            options.SlidingExpiration?.Ticks ?? -1,
            GetExpirationInSeconds(creationTime, GetAbsoluteExpiration(creationTime, options), options) ?? -1,
            value
        });
    }

    #endregion

    #region 获取缓存数据

    /// <summary>
    /// 获取缓存数据
    /// </summary>
    /// <param name="key"></param>
    /// <returns></returns>
    public byte[]? Get(string key)
    {
        return _redisDatabase.HashGet(key, "value");
    }

    /// <summary>
    /// 获取缓存数据
    /// </summary>
    /// <param name="key"></param>
    /// <param name="token"></param>
    /// <returns></returns>
    public async Task<byte[]?> GetAsync(string key, CancellationToken token)
    {
        return await _redisDatabase.HashGetAsync(key, "value");
    }

    #endregion

    #region 刷新缓存数据

    /// <summary>
    /// 刷新缓存
    /// </summary>
    /// <param name="key"></param>
    public void Refresh(string key)
    {
        _redisDatabase.KeyExpire(key, TimeSpan.FromMinutes(30));
    }

    /// <summary>
    /// 刷新缓存(异步)
    /// </summary>
    /// <param name="key"></param>
    /// <param name="token"></param>
    public async Task RefreshAsync(string key, CancellationToken token)
    {
         await _redisDatabase.KeyExpireAsync(key, TimeSpan.FromMinutes(30));
    }

    #endregion

    #region 删除缓存数据

    /// <summary>
    /// 删除缓存
    /// </summary>
    /// <param name="key"></param>
    public void Remove(string key)
    {
        _redisDatabase.KeyDelete(key);
    }

    /// <summary>
    /// 删除缓存（异步）
    /// </summary>
    /// <param name="key"></param>
    /// <param name="token"></param>
    public async Task RemoveAsync(string key, CancellationToken token)
    {
        await _redisDatabase.KeyDeleteAsync(key);
    }

    #endregion

    #endregion

    #region 分布式锁

    /// <summary>
    /// 获取分布式锁
    /// </summary>
    /// <param name="key"></param>
    /// <param name="expiry"></param>
    /// <param name="semaphore"></param>
    /// <returns></returns>
    public Dictionary<string, bool> Lock(string key, TimeSpan expiry = default, int semaphore = 1)
    {
        var dict = new Dictionary<string, bool>();
        try
        {
            if (expiry == default)
            {
                expiry = TimeSpan.FromMinutes(1);
            }


            for (var i = 0; i < semaphore; i++)
            {
                var keyMd5 = Convert.ToHexString(MD5.HashData(Encoding.UTF8.GetBytes(key + i)));

                var lockTakeAsync = _redisDatabase.LockTake(keyMd5, Guid.NewGuid().ToString(), expiry);

                dict.Add(keyMd5, lockTakeAsync);
            }
        }
        catch (Exception e)
        {
            _logger.LogError(e, ToString());
        }

        return dict;
    }

    /// <summary>
    /// 获取分布式锁（异步）
    /// </summary>
    /// <param name="key"></param>
    /// <param name="expiry"></param>
    /// <param name="semaphore"></param>
    /// <returns></returns>
    public async Task<Dictionary<string, bool>> LockAsync(string key, TimeSpan expiry = default, int semaphore = 1)
    {
        var dict = new Dictionary<string, bool>();
        try
        {
            if (expiry == default)
            {
                expiry = TimeSpan.FromMinutes(1);
            }

            for (var i = 0; i < semaphore; i++)
            {
                var keyMd5 = Convert.ToHexString(MD5.HashData(Encoding.UTF8.GetBytes(key + i)));

                var lockTakeAsync = await _redisDatabase.LockTakeAsync(keyMd5, Guid.NewGuid().ToString(), expiry);

                dict.Add(keyMd5, lockTakeAsync);
            }
        }
        catch (Exception e)
        {
            _logger.LogError(e.ToString());
        }

        return dict;
    }

    /// <summary>
    /// 释放分布式锁
    /// </summary>
    /// <param name="key"></param>
    /// <returns></returns>
    public bool LockRelease(string key)
    {
        var value = string.Empty;
        return _redisDatabase.LockRelease(key, value);
    }

    /// <summary>
    /// 释放分布式锁(异步)
    /// </summary>
    /// <param name="key"></param>
    /// <returns></returns>
    public async Task<bool> LockReleaseAsync(string key)
    {
        var value = string.Empty;
        return await _redisDatabase.LockReleaseAsync(key, value);
    }

    #endregion

    #region 缓存扩展

    /// <summary>
    /// 获取或添加缓存
    /// </summary>
    /// <typeparam name="TResult"></typeparam>
    /// <param name="key"></param>
    /// <param name="factory"></param>
    /// <param name="minutes"></param>
    /// <returns></returns>
    public async Task<TResult?> GetOrAddAsync<TResult>(string key, Func<Task<TResult>> factory, int minutes = -1)
    {
        TResult? cache = default;
        TimeSpan? timespan = default;
        try
        {
            var result = await _redisDatabase.StringGetAsync(key);
            if (string.IsNullOrEmpty(result))
            {
                cache = await factory.Invoke();

                if (minutes != -1)
                {
                    timespan = TimeSpan.FromMinutes(minutes);
                }

                await _redisDatabase.StringSetAsync(key, cache.ToJson(), timespan);
            }
            else
            {
                cache = result.ToString().FromJson<TResult>();
            }
        }
        catch (Exception e)
        {
            _logger.LogError(e.ToString());
        }

        return cache;
    }

    /// <summary>
    /// 添加或更新缓存
    /// </summary>
    /// <param name="key"></param>
    /// <param name="factory"></param>
    /// <param name="minutes"></param>
    /// <typeparam name="TResult"></typeparam>
    /// <returns></returns>
    public async Task<TResult?> AddOrUpdateAsync<TResult>(string key, Func<Task<TResult>> factory, int minutes = -1)
    {
        TResult? cache = default;
        TimeSpan? timespan = default;
        try
        {
            cache = await factory.Invoke();
            if (minutes != -1)
            {
                timespan = TimeSpan.FromMinutes(minutes);
            }

            await _redisDatabase.StringSetAsync(key, cache.ToJson(), timespan);
        }
        catch (Exception e)
        {
            _logger.LogError(e.ToString());
        }

        return cache;
    }

    /// <summary>
    /// 移除缓存
    /// </summary>
    /// <param name="key"></param>
    /// <returns></returns>
    public async Task<bool> RemoveAsync(string key)
    {
        try
        {
            var services = _connectionMultiplexer.GetServers();
            var list = services.FirstOrDefault()?.KeysAsync();
            var keys = list?.ToBlockingEnumerable().Where(x => x.ToString().StartsWith(key));

            if (keys is not null)
            {
                return await _redisDatabase.KeyDeleteAsync(keys.ToArray()) == keys.Count();
            }

            return true;
        }
        catch (Exception e)
        {
            _logger.LogError(e.ToString());
        }

        return false;
    }

    #endregion

    #region 发布订阅模式
    /// <summary>
    /// 发布消息（异步）
    /// </summary>
    /// <param name="channel"></param>
    /// <param name="message"></param>
    /// <typeparam name="T"></typeparam>
    public async Task PublishMessageAsync<T>(string channel, T message)
    {
        await _connectionMultiplexer.GetSubscriber().PublishAsync(new RedisChannel(channel, RedisChannel.PatternMode.Auto), message.ToJson());
    }

    /// <summary>
    /// 订阅消息（异步）
    /// </summary>
    /// <param name="channel"></param>
    /// <param name="action"></param>
    public async Task SubscribeMessageAsync<T>(string channel, Action<string, T> action)
    {
        var subscriber = _connectionMultiplexer.GetSubscriber();
        await subscriber.SubscribeAsync(new RedisChannel(channel, RedisChannel.PatternMode.Auto), (chain, message) =>
        {
            action.Invoke(chain!, message.FromObject<T>());

        });
    }
    #endregion

    #region 辅助方法

    private long? GetExpirationInSeconds(DateTimeOffset creationTime, DateTimeOffset? absoluteExpiration,
        DistributedCacheEntryOptions options)
    {
        if (absoluteExpiration.HasValue && options.SlidingExpiration.HasValue)
        {
            return (long)Math.Min(
                (absoluteExpiration.Value - creationTime).TotalSeconds,
                options.SlidingExpiration.Value.TotalSeconds);
        }
        else if (absoluteExpiration.HasValue)
        {
            return (long)(absoluteExpiration.Value - creationTime).TotalSeconds;
        }
        else if (options.SlidingExpiration.HasValue)
        {
            return (long)options.SlidingExpiration.Value.TotalSeconds;
        }

        return null;
    }

    private DateTimeOffset? GetAbsoluteExpiration(DateTimeOffset creationTime, DistributedCacheEntryOptions options)
    {
        if (options.AbsoluteExpiration.HasValue && options.AbsoluteExpiration <= creationTime)
        {
            throw new ArgumentOutOfRangeException(
                nameof(DistributedCacheEntryOptions.AbsoluteExpiration),
                options.AbsoluteExpiration.Value,
                "The absolute expiration value must be in the future.");
        }

        if (options.AbsoluteExpirationRelativeToNow.HasValue)
        {
            return creationTime + options.AbsoluteExpirationRelativeToNow;
        }

        return options.AbsoluteExpiration;
    }

    #endregion
}