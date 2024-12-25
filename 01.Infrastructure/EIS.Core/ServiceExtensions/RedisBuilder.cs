using EIS.Core.Options;
using Microsoft.Extensions.DependencyInjection;
using StackExchange.Redis;

namespace EIS.Core.ServiceExtensions;

/// <summary>
/// Redis构造器
/// </summary>
public static class RedisBuilder
{
    /// <summary>
    /// 添加Redis服务
    /// </summary>
    /// <param name="services"></param>
    /// <param name="options"></param>
    /// <returns></returns>
    /// <exception cref="ArgumentNullException"></exception>
    public static IServiceCollection AddRedisService(this IServiceCollection services,
        RedisOptions options)
    {
        if (options == null)
        {
            throw new ArgumentNullException(nameof(options));
        }

        var redisConnectionString = $"{options.Ip}:{options.Port}";
        // 创建Redis连接
        var redis = ConnectionMultiplexer.Connect(redisConnectionString, configurationOptions =>
        {
            configurationOptions.User = options.UserName == "" ? configurationOptions.User : options.UserName;
            configurationOptions.Password = options.Password == "" ? configurationOptions.Password : options.UserName;
        });

        // 注册Redis连接实例
        services.AddSingleton<IConnectionMultiplexer>(redis);

        return services;
    }
}