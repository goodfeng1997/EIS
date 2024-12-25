using System.Collections.Concurrent;
using EIS.Core.Base.DataBaseLinq;

namespace EIS.Core.Base.Tenant.Factory;

public interface ITenantFactory
{
    /// <summary>
    /// 初始化租户数据库连接
    /// </summary>
    /// <param name="dictionary"></param>
    /// <returns></returns>
    public bool InitTenantDatabaseConnectionAsync(ConcurrentDictionary<string, string> dictionary);

    /// <summary>
    /// 添加或更新租户数据库连接
    /// </summary>
    /// <param name="tenantId"></param>
    /// <param name="connectionString"></param>
    /// <returns></returns>
    public bool AddOrUpdateTenantDatabaseConnection(string tenantId, string connectionString);

    /// <summary>
    /// 移除租户数据库连接
    /// </summary>
    /// <param name="tenantId"></param>
    /// <returns></returns>
    public bool RemoveTenantDatabaseConnection(string tenantId);

    /// <summary>
    /// 获取租户数据库连接
    /// </summary>
    /// <param name="tenantId"></param>
    /// <returns></returns>
    public IDataBaseSql? GetTenantDatabaseConnection(string tenantId);
}