using EIS.Core.Base.DataBaseLinq;
using EIS.Model.Base;
using IdentityServer4.Models;
using IdentityServer4.Stores;

namespace EIS.Auth.Store;

/// <summary>
/// 自定义资源存储
/// </summary>
public class CustomResourceStore : IResourceStore
{
    private readonly IDbService _dbService;
    private readonly IEnumerable<IdentityResource> _identityResources;
    
    /// <summary>
    /// 构造函数
    /// </summary>
    /// <param name="dbService"></param>
    public CustomResourceStore(IDbService dbService)
    {
        _dbService = dbService;
        _identityResources = new List<IdentityResource>
        {
            new IdentityResources.OpenId(),
            new IdentityResources.Profile(),
        };
    }
    
    /// <summary>
    /// 获取IdentityResources
    /// </summary>
    /// <param name="scopeNames"></param>
    /// <returns></returns>
    public Task<IEnumerable<IdentityResource>> FindIdentityResourcesByScopeNameAsync(IEnumerable<string> scopeNames)
    {
        return Task.FromResult(_identityResources.Where(p => scopeNames.Contains(p.Name)));
    }

    /// <summary>
    /// 获取ApiScopes
    /// </summary>
    /// <param name="scopeNames"></param>
    /// <returns></returns>
    public  async Task<IEnumerable<ApiScope>> FindApiScopesByNameAsync(IEnumerable<string> scopeNames)
    {
        var result = await _dbService.QueryList<EISApi>(p => scopeNames.Contains(p.ApiScope));
        return result.Select(api => new ApiScope(api.ApiScope, api.ApiDesc));
    }

    /// <summary>
    /// 获取ApiResource
    /// </summary>
    /// <param name="scopeNames"></param>
    /// <returns></returns>
    public async Task<IEnumerable<ApiResource>> FindApiResourcesByScopeNameAsync(IEnumerable<string> scopeNames)
    {
        var result = await _dbService.QueryList<EISApi>(p => scopeNames.Contains(p.ApiScope));
        return result.Select(api => new ApiResource(api.ApiCode, api.ApiName) { Scopes = { api.ApiScope }, });
    }

    /// <summary>
    /// 获取ApiResource
    /// </summary>
    /// <param name="apiResourceNames"></param>
    /// <returns></returns>
    public async Task<IEnumerable<ApiResource>> FindApiResourcesByNameAsync(IEnumerable<string> apiResourceNames)
    {
        var result = await _dbService.QueryList<EISApi>(p => apiResourceNames.Contains(p.ApiCode));
        return result.Select(api => new ApiResource(api.ApiCode, api.ApiName) { Scopes = { api.ApiScope }, });
    }

    /// <summary>
    /// 获取所有资源
    /// </summary>
    /// <returns></returns>
    public async Task<Resources> GetAllResourcesAsync()
    {
        var result = await _dbService.QueryList<EISApi>(p => p.IsEnable && p.IsDelete);
        return new Resources
        (_identityResources,
            result.Select(api => new ApiResource(api.ApiCode, api.ApiName) { Scopes = { api.ApiScope }, }), 
            result.Select(api => new ApiScope(api.ApiScope, api.ApiDesc)));
    }
}