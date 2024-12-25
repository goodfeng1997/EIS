using System.Collections.Concurrent;
using System.Data;
using EIS.Core.Base.DataBaseLinq;
using Microsoft.Extensions.Logging;
using Npgsql;

namespace EIS.Core.Base.Tenant.Factory.Impl;

public class DapperFactory : ITenantFactory
{
    /// <summary>
    /// 宿主数据库
    /// </summary>
    private IDbConnection? _adminDbConnection;
    /// <summary>
    /// Dapper租户连接集合
    /// </summary>
    private readonly ConcurrentDictionary<string, IDbConnection> _dbConnections =
        new ConcurrentDictionary<string, IDbConnection>();

    /// <summary>
    /// 日志助手
    /// </summary>
    private readonly ILogger<DapperFactory> _logger;
        
    /// <summary>
    /// 构造函数
    /// </summary>
    public DapperFactory(IDbConnection dbConnection, ILogger<DapperFactory> logger)
    {
        _logger = logger;
        _adminDbConnection = dbConnection;
    }
    
    /// <summary>
    /// 初始化租户数据库连接
    /// </summary>
    /// <param name="dictionary"></param>
    /// <returns></returns>
    public bool InitTenantDatabaseConnectionAsync(ConcurrentDictionary<string, string> dictionary)
    {
        _dbConnections.Clear();
        foreach (var tenant in dictionary)
        {
            _dbConnections.TryAdd(tenant.Key, new NpgsqlConnection(tenant.Value));
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
        if (_dbConnections.TryGetValue(tenantId, out var connection))
        {
            if(connection.State != ConnectionState.Closed)
            {
                connection.Close();
                connection.Dispose();
            }

            _dbConnections.TryRemove(tenantId, out _);
                    
            return _dbConnections.TryAdd(tenantId, new NpgsqlConnection(connectionString));
        }
        else
        {
            return _dbConnections.TryAdd(tenantId, new NpgsqlConnection(connectionString));
        }
    }

    /// <summary>
    /// 移除租户数据库连接
    /// </summary>
    /// <param name="tenantId"></param>
    /// <returns></returns>
    public bool RemoveTenantDatabaseConnection(string tenantId)
    {
        if (_dbConnections.TryGetValue(tenantId, out var connection))
        {
            if (connection.State != ConnectionState.Closed)
            {
                connection.Close();
                connection.Dispose();
            }

            _dbConnections.TryRemove(tenantId, out _);
            return true;
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
        _dbConnections.TryGetValue(tenantId, out var connection);
        return connection as IDataBaseSql;
    }
}