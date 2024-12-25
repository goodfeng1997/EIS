using System.Collections.Concurrent;
using EIS.Model.Base;

namespace EIS.Core.Options;

/// <summary>
/// 租户数据库选项
/// </summary>
public class TenantDatabaseOptions
{
    /// <summary>
    /// Orm类型
    /// </summary>
    internal string MapType = string.Empty;
    
    /// <summary>
    /// 数据库连接集合
    /// </summary>
    private ConcurrentDictionary<string, string> ConnectionStrings { get; } =
        new ConcurrentDictionary<string, string>();

    /// <summary>
    /// 获取所有租户连接配置
    /// </summary>
    /// <returns></returns>
    public ConcurrentDictionary<string, string> GetTenantDatabaseAll()
    {
        return ConnectionStrings;
    }

    /// <summary>
    /// 获取特定租户连接配置
    /// </summary>
    /// <param name="tenantId"></param>
    /// <returns></returns>
    public (string, string?) GetTenantDatabase(string tenantId)
    {
        if (ConnectionStrings.TryGetValue(tenantId, out var connection))
        {
            return (tenantId, connection);
        }
        else
        {
            return (tenantId, null);
        }
    }
    
    /// <summary>
    /// 添加或新增租户数据库配置
    /// </summary>
    /// <param name="tenantId"></param>
    /// <param name="config"></param>
    /// <param name="connectionString"></param>
    /// <returns></returns>
    public bool AddOrUpdateTenantDatabase(string tenantId, TenantConfig config, out string connectionString)
    {
        connectionString =
            $"Host={config.DbHost};Port={config.DbPort};Database={config.DbName};Username={config.DbUser};Password={config.DbPassword};";
        if (ConnectionStrings.ContainsKey(tenantId))
        {
            ConnectionStrings[tenantId] = connectionString;
            return true;
        }
        else
        {
            return ConnectionStrings.TryAdd(tenantId, connectionString);
        }
    }
    
    /// <summary>
    /// 添加或新增租户数据库配置
    /// </summary>
    /// <param name="tenantId"></param>
    /// <param name="connectionString"></param>
    /// <returns></returns>
    public bool AddOrUpdateTenantDatabase(string tenantId, string connectionString)
    {
        if (ConnectionStrings.ContainsKey(tenantId))
        {
            ConnectionStrings[tenantId] = connectionString;
            return true;
        }
        else
        {
            return ConnectionStrings.TryAdd(tenantId, connectionString);
        }
    }

    /// <summary>
    /// 移除租户数据库配置
    /// </summary>
    /// <param name="tenantId"></param>
    /// <returns></returns>
    public bool RemoveTenantDatabase(string tenantId)
    {
        return ConnectionStrings.TryRemove(tenantId, out _);
    }
}