using EIS.Core.Base.DataBaseLinq;
using EIS.Core.Base.Tenant.Factory;
using EIS.Core.Options;
using EIS.Model.Base;
using Microsoft.Extensions.Logging;

namespace EIS.Core.Base.Tenant.Impl;

public class TenantDatabaseProvider : ITenantDatabaseProvider
{
    private bool _initialTenantDatabase;
    private readonly ILogger<TenantDatabaseProvider> _logger;
    private readonly TenantDatabaseOptions _tenantDatabaseOptions;
    private readonly ITenantFactory _tenantFactory;

    /// <summary>
    /// 构造函数
    /// </summary>
    /// <param name="tenantDatabaseOptions"></param>
    /// <param name="logger"></param>
    /// <param name="tenantFactory"></param>
    public TenantDatabaseProvider(TenantDatabaseOptions tenantDatabaseOptions, 
        ILogger<TenantDatabaseProvider> logger, ITenantFactory tenantFactory)
    {
        _logger = logger;
        _tenantDatabaseOptions = tenantDatabaseOptions;
        _tenantFactory = tenantFactory;
    }
    
    /// <summary>
    /// 初始化租户数据库连接
    /// </summary>
    /// <returns></returns>
    public Task<bool> InitTenantDatabaseConnectionAsync()
    {
        try
        {
            if (_initialTenantDatabase)
            {
                return Task.FromResult(true);
            }
            var dict = _tenantDatabaseOptions.GetTenantDatabaseAll();
            _initialTenantDatabase = _tenantFactory.InitTenantDatabaseConnectionAsync(dict);
        }
        catch (Exception e)
        {
            _logger.LogError(e.ToString());
            return Task.FromResult(false);
        }
        return Task.FromResult(true);
    }

    /// <summary>
    /// 添加或更新租户数据库连接
    /// </summary>
    /// <param name="tenantId"></param>
    /// <param name="config"></param>
    /// <returns></returns>
    public bool AddOrUpdateTenantDatabaseConnection(string tenantId, TenantConfig config)
    {
        try
        {
            if (_tenantDatabaseOptions.AddOrUpdateTenantDatabase(tenantId, config, out var connectionString))
            {
                return _tenantFactory.AddOrUpdateTenantDatabaseConnection(tenantId,connectionString);
            }
            else
            {
                return false;
            }
        }
        catch (Exception e)
        {
            _logger.LogError(e.ToString());
            return false;
        }
    }

    /// <summary>
    /// 移除租户数据库连接
    /// </summary>
    /// <param name="tenantId"></param>
    /// <returns></returns>
    public bool RemoveTenantDatabaseConnection(string tenantId)
    {
        try
        {
            return _tenantFactory.RemoveTenantDatabaseConnection(tenantId);
        }
        catch (Exception e)
        {
            _logger.LogError(e.ToString());
            return false;
        }
    }

    /// <summary>
    /// 获取租户数据库连接
    /// </summary>
    /// <param name="tenantId"></param>
    /// <returns></returns>
    public IDataBaseSql? GetTenantDatabaseConnection(string tenantId)
    {
        return _tenantFactory.GetTenantDatabaseConnection(tenantId);
    }
}