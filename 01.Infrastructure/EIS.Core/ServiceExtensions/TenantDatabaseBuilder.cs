using EIS.Core.Base.Tenant;
using EIS.Core.Options;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace EIS.Core.ServiceExtensions;

/// <summary>
/// 租户数据库构建器
/// </summary>
public static class TenantDatabaseBuilder
{
    /// <summary>
    /// 注入租户数据库
    /// </summary>
    /// <param name="services"></param>
    /// <param name="configuration"></param>
    /// <param name="action"></param>
    /// <returns></returns>
    /// <exception cref="ArgumentNullException"></exception>
    public static IServiceCollection AddTenantDatabase(this IServiceCollection services,
        ConfigurationManager configuration,
        Func<TenantDatabaseOptions, Task> action)
    {
        if (action == null)
        {
            throw new ArgumentNullException(nameof(action));
        }

        var options = new TenantDatabaseOptions()
        {
            MapType = configuration["DataBase:MapType"] ?? string.Empty
        };

        action.Invoke(options);
        // 注入租户数据库配置
        services.AddSingleton(options);
        
        return services;
    }

    /// <summary>
    /// 使用租户数据库
    /// </summary>
    /// <param name="app"></param>
    /// <returns></returns>
    public static IApplicationBuilder UseTenantDatabase(this IApplicationBuilder app)
    {
        if (app == null)
        {
            throw new ArgumentNullException(nameof(app));
        }

        // 获取ITenantDatabaseProvider服务
        var provider = app.ApplicationServices.GetRequiredService<ITenantDatabaseProvider>();
        
        // 实例化
        provider.InitTenantDatabaseConnectionAsync();
        return app;
    }
}