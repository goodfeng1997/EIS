using System.Collections.Concurrent;
using EIS.Core.Base.DataBaseLinq;
using FreeSql;
using Microsoft.Extensions.Logging;

namespace EIS.Core.Base.Tenant.Factory.Impl;

public class FreeSqlFactory : ITenantFactory
{
    /// <summary>
    /// 日志助手
    /// </summary>
    private readonly ILogger<FreeSqlFactory> _logger;
    
    /// <summary>
    /// FreeSql连接集合
    /// </summary>
    private readonly FreeSqlCloud<string> _freeSqlCloud;
    
    /// <summary>
    /// 构造函数
    /// </summary>
    public FreeSqlFactory(FreeSqlCloud<string> freeSqlCloud, ILogger<FreeSqlFactory> logger)
    {
        _freeSqlCloud = freeSqlCloud;
        _logger = logger;
    }

    /// <summary>
    /// 初始化管理数据库连接
    /// </summary>
    /// <param name="master"></param>
    /// <param name="connectionString"></param>
    /// <returns></returns>
    public bool InitAdminDatabaseConnectionAsync(string master, string connectionString)
    {
        _freeSqlCloud.Register("main", () =>
        {
            var db = new FreeSqlBuilder().UseConnectionString(DataType.PostgreSQL, connectionString).Build();
            db.Aop.CommandAfter += (sender, args) =>
            {
                Console.WriteLine($"SQL:{args.Command}\nElapsed:{args.ElapsedMilliseconds}ms");
            };
            return db;
        });
        return true;
    }
    
    /// <summary>
    /// 初始化租户数据库连接
    /// </summary>
    /// <param name="dictionary"></param>
    /// <returns></returns>
    public bool InitTenantDatabaseConnectionAsync(ConcurrentDictionary<string, string> dictionary)
    {
        foreach (var tenant in dictionary)
        {
            _freeSqlCloud.Register(tenant.Key, () =>
            {
                var db = new FreeSqlBuilder().UseConnectionString(DataType.PostgreSQL, tenant.Value).Build();
                db.Aop.CommandAfter += (sender, args) =>
                {
                    _logger.LogDebug($"SQL:{args.Command}\nElapsed:{args.ElapsedMilliseconds}ms");
                };
                return db;
            });
        }
        return true;
    }

    /// <summary>
    /// 添加或更新租户数据库连接
    /// </summary>
    /// <param name="tenantId"></param>
    /// <param name="connectionString"></param>
    /// <returns></returns>
    public bool AddOrUpdateTenantDatabaseConnection(string tenantId, string connectionString)
    {
        if (_freeSqlCloud.ExistsRegister(tenantId))
        {
            _freeSqlCloud.RemoveRegister(tenantId);
        }
        _freeSqlCloud.Register(tenantId, () =>
        {
            var db = new FreeSqlBuilder().UseConnectionString(DataType.PostgreSQL, connectionString).Build();
            db.Aop.CommandAfter += (sender, args) =>
            {
                _logger.LogDebug($"SQL:{args.Command}\nElapsed:{args.ElapsedMilliseconds}ms");
            };
            return db;
        });
        return true;
    }

    /// <summary>
    /// 移除租户数据库连接
    /// </summary>
    /// <param name="tenantId"></param>
    /// <returns></returns>
    public bool RemoveTenantDatabaseConnection(string tenantId)
    {
        if (_freeSqlCloud.ExistsRegister(tenantId))
        {
            return _freeSqlCloud.RemoveRegister(tenantId);
        }
        return false;
    }
    
    /// <summary>
    /// 获取租户数据库连接
    /// </summary>
    /// <param name="tenantId"></param>
    /// <returns></returns>
    public IDataBaseSql? GetTenantDatabaseConnection(string tenantId)
    {
        return _freeSqlCloud.Use(tenantId) as IDataBaseSql;
    }
}