using EIS.Core.Base.DataBaseLinq;
using EIS.Model.Base;
using IdentityServer4.Models;
using IdentityServer4.Stores;

namespace EIS.Auth.Store;

/// <summary>
/// 自定义客户端
/// </summary>
public class CustomClientStore : IClientStore
{
    private readonly IDbService _dbService;
    
    /// <summary>
    /// 构造函数
    /// </summary>
    /// <param name="dbService"></param>
    public CustomClientStore(IDbService dbService)
    {
        _dbService = dbService;
    }
    
    /// <summary>
    /// 获取Client
    /// </summary>
    /// <param name="clientId"></param>
    /// <returns></returns>
    public async Task<Client> FindClientByIdAsync(string clientId)
    { 
        var client = await _dbService.Query<EISClient>(t => t.ClientId == clientId);
        var apiScope = await _dbService.QueryList<ClientApi,EISApi,ApiScope>((t1, t2) => t1.ClientId.Equals(clientId) && t1.IsEnable && t2.IsEnable, 
            (t1, t2)=> t1.ApiId == t2.Id,
            (t1, t2) => new ApiScope() { Name = t1.ApiScope, DisplayName = t2.ApiScope });
        return new Client()
        {
            ClientId = client?.ClientId,
            ClientName = client?.ClientName,
            AllowedGrantTypes = GrantTypes.ResourceOwnerPasswordAndClientCredentials,
            AccessTokenType = AccessTokenType.Jwt,
            AllowOfflineAccess = true,
            AbsoluteRefreshTokenLifetime = 86400, // 刷新令牌的绝对有效期为30天
            SlidingRefreshTokenLifetime = 86400, // 刷新令牌的滑动有效期为30天
            ClientSecrets = { new Secret(client?.ClientSecret.Sha256()) },
            AllowedScopes = apiScope.Select(p => p.Name).ToList()
        };
    }
}