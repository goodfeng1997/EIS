using Consul;
using Consul.AspNetCore;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace EIS.Core.ServiceExtensions;

public static class ConsulBuilder
{
    /// <summary>
    /// 添加Consul服务
    /// </summary>
    /// <param name="services"></param>
    /// <param name="configuration"></param>
    /// <param name="isHealthCheck"></param>
    /// <returns></returns>
    public static IServiceCollection AddConsulService(this IServiceCollection services,
        ConfigurationManager configuration, bool isHealthCheck = true)
    {
        // 通过consul提供的注入方式注册consulClient
        services.AddConsul(options =>
            options.Address = new Uri($"http://{configuration["Consul.IP"]}:{configuration["Consul.Port"]}"));

        // 通过consul提供的注入方式进行服务注册
        var httpCheck = new AgentServiceCheck()
        {
            DeregisterCriticalServiceAfter = TimeSpan.FromSeconds(5), //服务启动多久后注册
            Interval = TimeSpan.FromSeconds(10), //健康检查时间间隔，或者称为心跳间隔
            HTTP = $"http://{configuration["HealthCheck.IP"]}:{configuration["Service.Port"]}/health", //健康检查地址
            Timeout = TimeSpan.FromSeconds(10)
        };

        // Register service with consul
        services.AddConsulServiceRegistration(options =>
        {
            options.Checks = isHealthCheck ? new[] { httpCheck } : null;
            options.ID = configuration["Service.Name"];
            options.Name = configuration["Service.CodeEnum"];
            options.Address = configuration["HealthCheck.IP"];
            options.Port = Convert.ToInt32(configuration["Service.Port"]);
            options.Meta = new Dictionary<string, string>() { { "Weight", "1" } };
            options.Tags = new[] { $"eis-/{configuration["Service.CodeEnum"]}" };
        });

        return services;
    }
    
    /// <summary>
    /// 配置Consul检查服务
    /// </summary>
    /// <param name="app"></param>
    /// <returns></returns>
    public static IApplicationBuilder UseConsulCheckService(this IApplicationBuilder app)
    {
        app.Map("/health", appBuilder =>
        {
            appBuilder.Run(async context =>
            {
                await Task.Run(() => context.Response.StatusCode = 200);
            });
        });

        return app;
    }
}