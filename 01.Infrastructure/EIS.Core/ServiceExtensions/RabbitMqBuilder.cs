using EIS.Core.Services;
using EIS.Core.Services.Impl;
using EIS.Shared.Extensions;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using RabbitMQ.Client;

namespace EIS.Core.ServiceExtensions;

public static class RabbitMqBuilder
{
    /// <summary>
    /// 添加RabbitMQ服务
    /// </summary>
    /// <param name="services"></param>
    /// <param name="configuration"></param>
    /// <returns></returns>
    public static async Task<IServiceCollection> AddRabbitMqService(this IServiceCollection services,
        ConfigurationManager configuration)
    {
        // 创建一个连接工厂
        var factory = new ConnectionFactory()
        {
            HostName = configuration["RabbitMQ:HostName"],
            Port = configuration["RabbitMQ:Port"].TryToInt(),
            UserName = configuration["RabbitMQ:UserName"],
            Password = configuration["RabbitMQ:Password"],
            AutomaticRecoveryEnabled = true
        };
        
        // 创建连接
        var connection =  await factory.CreateConnectionAsync();
        
        services.AddSingleton<IConnection>(connection);

        services.AddSingleton<IRabbitMqService, RabbitMqService>();
        return services;
    }
}