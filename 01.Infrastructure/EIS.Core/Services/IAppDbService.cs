using EIS.Core.Base.DataBaseLinq;

namespace EIS.Core.Services;

public interface IAppDbService
{
    /// <summary>
    /// 标记属性(租户连接对象)
    /// </summary>
    /// <param name="tenantId"></param>
    public IDataBaseSql? this[string tenantId] { get; }
    
    /// <summary>
    /// 标记属性(超级管理员连接对象)
    /// </summary>
    public IDataBaseSql? AdminHost { get; }

    /// <summary>
    /// 执行租户数据库操作
    /// </summary>
    /// <param name="tenantId"></param>
    /// <param name="execAction"></param>
    /// <typeparam name="T"></typeparam>
    /// <returns></returns>
    public Task<T>? ExecuteTenantDbAsync<T>(string tenantId, Func<IDataBaseSql, Task<T>?> execAction);
}