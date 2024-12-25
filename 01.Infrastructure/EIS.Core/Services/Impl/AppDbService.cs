using EIS.Core.Base.DataBaseLinq;
using EIS.Core.Base.Tenant;
using Microsoft.Extensions.Logging;

namespace EIS.Core.Services.Impl;

/// <summary>
/// 租户数据服务
/// </summary>
/// <param name="logger"></param>
/// <param name="tenantDatabaseProvider"></param>
public class AppDbService(ILogger<AppDbService> logger, ITenantDatabaseProvider tenantDatabaseProvider)
    : IAppDbService
{
    /// <summary>
    /// 数据库连接属性
    /// </summary>
    /// <param name="tenantId"></param>
    public IDataBaseSql? this[string tenantId] => tenantDatabaseProvider.GetTenantDatabaseConnection(tenantId);
    
    /// <summary>
    /// 标记属性(超级管理员连接对象)
    /// </summary>
    public IDataBaseSql? AdminHost => tenantDatabaseProvider.GetTenantDatabaseConnection("admin");

    /// <summary>
    /// 执行租户数据库操作
    /// </summary>
    /// <param name="tenantId"></param>
    /// <param name="execAction"></param>
    /// <typeparam name="T"></typeparam>
    /// <returns></returns>
    public Task<T>? ExecuteTenantDbAsync<T>(string tenantId, Func<IDataBaseSql, Task<T>?> execAction)
    {
        try
        {
            var dataBaseSql = tenantDatabaseProvider.GetTenantDatabaseConnection(tenantId);
            if (dataBaseSql is null)
            {
                return null;
            }

            return execAction.Invoke(dataBaseSql);
        }
        catch (Exception e)
        {
            logger.LogError(e.ToString());
            return null;
        }
    }
}