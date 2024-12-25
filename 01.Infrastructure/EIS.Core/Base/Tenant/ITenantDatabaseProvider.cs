using EIS.Core.Base.DataBaseLinq;
using EIS.Model.Base;

namespace EIS.Core.Base.Tenant;

public interface ITenantDatabaseProvider
{
    /// <summary>
    /// 多租户连接初始化
    /// </summary>
    /// <returns></returns>
    public Task<bool> InitTenantDatabaseConnectionAsync();

    /// <summary>
    /// 添加或更新租户数据库连接
    /// </summary>
    /// <param name="tenantId"></param>
    /// <param name="config"></param>
    /// <returns></returns>
    public bool AddOrUpdateTenantDatabaseConnection(string tenantId, TenantConfig config);

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