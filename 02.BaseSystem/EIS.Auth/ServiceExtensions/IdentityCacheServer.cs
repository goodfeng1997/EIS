using System.Data;
using Dapper;
using EIS.Model.Base;
using IdentityServer4.Models;

namespace EIS.Auth.ServiceExtensions;

/// <summary>
/// IdentityServer4缓存服务
/// </summary>
public static class IdentityCacheServer
{
    /// <summary>
    /// 获取系统Api资源
    /// </summary>
    /// <param name="dbConnection"></param>
    /// <returns></returns>
    public static IEnumerable<ApiResource> GetApiResources(IDbConnection dbConnection)
    {
        var result = dbConnection.Query<EISApi>("SELECT * FROM api");
        return result.Select(api => new ApiResource(api.ApiCode, api.ApiName) { Scopes = { api.ApiScope }, }).ToList();
    }

    /// <summary>
    /// 获取系统Api范围
    /// </summary>
    /// <param name="dbConnection"></param>
    /// <returns></returns>
    public static IEnumerable<ApiScope> GetApiScopes(IDbConnection dbConnection)
    {
        var result = dbConnection.Query<EISApi>("SELECT * FROM api");
        return result.Select(api => new ApiScope(api.ApiScope, api.ApiDesc)).ToList();
    }

    /// <summary>
    /// 获取系统客户端
    /// </summary>
    /// <returns></returns>
    public static IEnumerable<Client> GetClients(IDbConnection dbConnection)
    {
        var result = dbConnection.Query<EISClient>("SELECT * FROM client");
        var resultDetail = dbConnection.Query<ClientApi>("SELECT A.*, B.\"ApiScope\"  FROM client_api A LEFT JOIN api B ON A.\"ApiId\"=B.\"Id\"")
            .ToList();
        return result.Select(client => new Client()
            {
                ClientId = client.ClientId,
                ClientName = client.ClientName,
                AllowedGrantTypes = GrantTypes.ResourceOwnerPasswordAndClientCredentials,
                AccessTokenType = AccessTokenType.Jwt,
                AllowOfflineAccess = true,
                AbsoluteRefreshTokenLifetime = 86400, // 刷新令牌的绝对有效期为30天
                SlidingRefreshTokenLifetime = 86400, // 刷新令牌的滑动有效期为30天
                ClientSecrets = { new Secret(client.ClientSecret.Sha256()) },
                AllowedScopes = resultDetail.Where(api => api.ClientId == client.Id).Select(api => api.ApiScope).ToList()
            })
            .ToList();
    }

    /// <summary>
    /// 获取鉴权资源
    /// </summary>
    /// <returns></returns>
    public static IEnumerable<IdentityResource> GetIdentityResources()
    {
        return new List<IdentityResource>
        {
            new IdentityResources.OpenId(),
            new IdentityResources.Profile(),
        };
    }
}