using System.Data;
using System.Security.Claims;
using Dapper;
using EIS.Core.Services;
using EIS.Model.Base;
using EIS.Shared.Extensions;
using IdentityModel;
using IdentityServer4.Models;
using IdentityServer4.Validation;

namespace EIS.Auth.ServiceExtensions;

/// <summary>
/// Identity Server4 资源所有者验证
/// </summary>
public class ResourceOwnerPasswordValidator : IResourceOwnerPasswordValidator
{
    private readonly IDbConnection _dbConnection;
    private readonly IAppDbService _appDbService;
    private readonly ILogger<ResourceOwnerPasswordValidator> _logger;

    /// <summary>
    /// 构造函数
    /// </summary>
    /// <param name="dbConnection"></param>
    /// <param name="appDbService"></param>
    /// <param name="logger"></param>
    public ResourceOwnerPasswordValidator(IDbConnection dbConnection, 
        IAppDbService appDbService,
        ILogger<ResourceOwnerPasswordValidator> logger)
    {
        this._logger = logger;
        this._dbConnection = dbConnection;
        this._appDbService = appDbService;
    }

    /// <summary>
    /// 验证用户信息（在请求ACCESS_TOKEN时调用）
    /// </summary>
    /// <param name="context"></param>
    public async Task ValidateAsync(ResourceOwnerPasswordValidationContext context)
    {
        try
        {
            var loginUser = new User();
            // 判断是租户用户，还是管理用户
            var authId = context.Request.Raw["authorization_code"];
            if (authId.IsNullOrWhiteSpace())
            {
                loginUser = await _dbConnection.QuerySingleOrDefaultAsync<User>(
                    "SELECT * FROM public.user WHERE \"UserCode\"=@UserName AND \"UserPassWord\"=@PassWord AND COALESCE(\"IsDelete\",false)=false AND COALESCE(\"IsEnable\",false)=true",
                    new { context.UserName, context.Password });
            }
            else
            {
                var authCode = await _dbConnection.QuerySingleOrDefaultAsync<TenantAuthCode>("select * from tenant_authcode where \"Id\"=@Id",
                    new { Id = authId.ToGuid() });
                if (authCode is null)
                {
                    context.Result =
                        new GrantValidationResult(TokenRequestErrors.InvalidRequest, "Invalid client credential");
                    return;
                }
                var connection = _appDbService[authCode.AuthTenant.ToString()];
                if (connection is null)
                {
                    context.Result =
                        new GrantValidationResult(TokenRequestErrors.InvalidRequest, "Invalid client credential");
                    return;
                }
                else
                {
                    loginUser = await connection.QuerySingleOrDefaultAsync<User>(
                        "SELECT * FROM public.user WHERE \"UserCode\"=@UserName AND \"UserPassWord\"=@PassWord AND COALESCE(\"IsDelete\",false)=false AND COALESCE(\"IsEnable\",false)=true",
                        new { context.UserName, context.Password });
                }
            }

            if (loginUser is null || !loginUser.IsEnable)
            {
                context.Result =
                    new GrantValidationResult(TokenRequestErrors.InvalidRequest, "Invalid client credential");
            }
            else
            {
                context.Result = new GrantValidationResult(
                    subject: context.UserName,
                    authenticationMethod: OidcConstants.AuthenticationMethods.Password,
                    claims: new[]
                    {
                        new Claim("Id", loginUser.Id.ToString()),
                        new Claim("UserCode", loginUser.UserCode),
                        new Claim("Name", loginUser.UserName),
                        new Claim("UserType", loginUser.UserType),
                        new Claim("AuthCode", authId ?? "")
                    }
                );
            }
        }
        catch (Exception e)
        {
            _logger.LogError(e.ToString());
            throw;
        }
    }
}