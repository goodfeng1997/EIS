using Microsoft.Extensions.Caching.Distributed;

namespace EIS.Core.Services;

public interface IRedisStackCacheService : IDistributedCache
{
    /// <summary>
    /// 获取锁
    /// </summary>
    /// <param name="key">锁的名称，不可重复</param>
    /// <param name="expiry">失效时长</param>
    /// <param name="semaphore">信号量</param>
    /// <returns></returns>
    public Dictionary<string, bool> Lock(string key, TimeSpan expiry = default, int semaphore = 1);

    /// <summary>
    /// 获取锁（异步）
    /// </summary>
    /// <param name="key">锁的名称，不可重复</param>
    /// <param name="expiry">失效时长</param>
    /// <param name="semaphore">信号量</param>
    /// <returns></returns>
    public Task<Dictionary<string, bool>> LockAsync(string key, TimeSpan expiry = default, int semaphore = 1);

    /// <summary>
    /// 释放分布式锁
    /// </summary>
    /// <param name="key"></param>
    /// <returns></returns>
    public bool LockRelease(string key);

    /// <summary>
    /// 释放分布式锁(异步)
    /// </summary>
    /// <param name="key"></param>
    /// <returns></returns>
    public Task<bool> LockReleaseAsync(string key);
    
    /// <summary>
    /// 获取或添加缓存
    /// </summary>
    /// <typeparam name="TResult"></typeparam>
    /// <param name="key"></param>
    /// <param name="factory"></param>
    /// <param name="minutes"></param>
    /// <returns></returns>
    public Task<TResult?> GetOrAddAsync<TResult>(string key, Func<Task<TResult>> factory, int minutes = -1);

    /// <summary>
    /// 添加或更新缓存
    /// </summary>
    /// <param name="key"></param>
    /// <param name="factory"></param>
    /// <param name="minutes"></param>
    /// <typeparam name="TResult"></typeparam>
    /// <returns></returns>
    public Task<TResult?> AddOrUpdateAsync<TResult>(string key, Func<Task<TResult>> factory, int minutes = -1);

    /// <summary>
    /// 移除缓存
    /// </summary>
    /// <param name="key"></param>
    /// <returns></returns>
    public Task<bool> RemoveAsync(string key);

    /// <summary>
    /// 发布消息（异步）
    /// </summary>
    /// <param name="channel"></param>
    /// <param name="message"></param>
    /// <typeparam name="T"></typeparam>
    public Task PublishMessageAsync<T>(string channel, T message);

    /// <summary>
    /// 订阅消息（异步）
    /// </summary>
    /// <param name="channel"></param>
    /// <param name="action"></param>
    public Task SubscribeMessageAsync<T>(string channel, Action<string, T> action);
}