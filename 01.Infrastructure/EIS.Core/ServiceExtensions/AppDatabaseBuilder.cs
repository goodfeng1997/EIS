using System.Data;
using Dapper;
using EIS.Core.Base.DataBaseLinq;
using EIS.Core.Base.DataBaseLinq.Impl;
using EIS.Core.Base.Tenant;
using EIS.Core.Base.Tenant.Factory;
using EIS.Core.Base.Tenant.Factory.Impl;
using EIS.Core.Base.Tenant.Impl;
using EIS.Core.Services;
using EIS.Core.Services.Impl;
using EIS.Model.Base;
using EIS.Shared.Consts;
using EIS.Shared.Extensions;
using FreeSql;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;
using Npgsql;


namespace EIS.Core.ServiceExtensions;

public static class AppDatabaseBuilder
{
    /// <summary>
    /// 增加应用数据库
    /// </summary>
    /// <param name="services"></param>
    /// <param name="configuration"></param>
    /// <returns></returns>
    public static IServiceCollection AddAppDatabase(this IServiceCollection services, ConfigurationManager configuration)
    {
        var objMapType = configuration["DataBase:MapType"] ?? string.Empty;
        if (objMapType.IsNullOrWhiteSpace())
        {
            throw new ArgumentException();
        } 
        
        switch (objMapType)
        {
            case ObjectMapTypeConst.Dapper:
                services.AddTransient<IDbService,DapperDbService>();
                services.AddDapperDatabase(configuration);
                services.AddSingleton<ITenantFactory, DapperFactory>();
                break;
            case "FreeSql":
                services.AddTransient<IDbService,FreeSqlDbService>();
                services.AddFreeSqlDatabase(configuration);
                services.AddSingleton<ITenantFactory, FreeSqlFactory>();
                break;
        }
        services.AddAppDbService();
        return services;
    }

    /// <summary>
    /// 使用应用数据库
    /// </summary>
    /// <param name="app"></param>
    /// <param name="configuration"></param>
    /// <returns></returns>
    public static IApplicationBuilder UseAppDatabase(this IApplicationBuilder app, ConfigurationManager configuration)
    {
        app.UseTenantDatabase();
        return app;
    }

    /// <summary>
    /// 注入App数据服务
    /// </summary>
    /// <param name="services"></param>
    private static void AddAppDbService(this IServiceCollection services)
    {
        // 注入租户数据库提供者
        services.AddSingleton<ITenantDatabaseProvider, TenantDatabaseProvider>();

        // 注入数据库
        services.AddTransient<IAppDbService, AppDbService>();
    }
    
    /// <summary>
    /// 添加Dapper数据库
    /// </summary>
    /// <param name="services"></param>
    /// <param name="configuration"></param>
    private static void AddDapperDatabase(this IServiceCollection services, 
        ConfigurationManager configuration)
    {
        // 添加主数据库对象
        var _adminDbConnection = new NpgsqlConnection(configuration["DataBase:PostgreSql"]?? "");
        // 添加租户数据库对象
        services.AddTenantDatabase(configuration, action =>
        {
            var list =  _adminDbConnection.Query<TenantConfig>("select * from tenant_config where \"IsEnable\" = true and \"IsDelete\" = false");
            foreach (var tenant in list)
            {
                action.AddOrUpdateTenantDatabase(tenant.TenantId.ToString(), tenant, out _);
            }

            return Task.CompletedTask;
        });
        services.AddSingleton<IDbConnection>(_adminDbConnection);
    }

    /// <summary>
    /// 添加FreeSql数据库
    /// </summary>
    /// <param name="services"></param>
    /// <param name="configuration"></param>
    private static void AddFreeSqlDatabase(this IServiceCollection services,
        ConfigurationManager configuration)
    {
        var freeSqlCloud = new FreeSqlCloud<string>();
        freeSqlCloud.DistributeTrace = log => Console.WriteLine(log.Split('\n')[0].Trim());
        // 添加主数据库对象
        freeSqlCloud.Register("main", () =>
        {
            var db = new FreeSqlBuilder().UseConnectionString(DataType.PostgreSQL, configuration["DataBase:PostgreSql"]?? "").Build();
            db.Aop.CommandAfter += (sender, args) =>
            {
                Console.WriteLine($"SQL:{args.Command}\nElapsed:{args.ElapsedMilliseconds}ms");
            };
            return db;
        });
        
        // 添加租户数据库对象
        services.AddTenantDatabase(configuration,action =>
        {
            var list =  freeSqlCloud.Select<TenantConfig>().Where(p => p.IsEnable && !p.IsDelete).ToList();
            foreach (var tenant in list)
            {
                action.AddOrUpdateTenantDatabase(tenant.TenantId.ToString(), tenant, out _);
            }

            return Task.CompletedTask;
        });

        services.AddSingleton<IFreeSql>(freeSqlCloud);
    }
}