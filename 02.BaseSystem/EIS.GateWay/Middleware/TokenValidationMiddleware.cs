using System.IdentityModel.Tokens.Jwt;
using EIS.Core.Base.DataBaseLinq;
using EIS.Model.Base;
using EIS.Shared.Extensions;

namespace EIS.GateWay.Middleware;

public class TokenValidationMiddleware
{
    private readonly RequestDelegate _next;
    private readonly IDbService _dbService;
    private readonly ILogger<TokenValidationMiddleware> _logger;

    /// <summary>
    /// token验证中间件
    /// </summary>
    /// <param name="next"></param>
    /// <param name="dbService"></param>
    /// <param name="logger"></param>
    public TokenValidationMiddleware(RequestDelegate next, IDbService dbService, ILogger<TokenValidationMiddleware> logger)
    {
        _next = next;
        _logger = logger;
        _dbService = dbService;
    }
    
    /// <summary>
    /// 中间件触发
    /// </summary>
    /// <param name="context"></param>
    public async Task Invoke(HttpContext context)
    {
        var path = context.Request.Path;
        // 检查请求路径是否为 /auth/login登录路径以及swagger路径
        if (!path.Equals("/auth/login", StringComparison.OrdinalIgnoreCase) 
            && !(path.Value?.Contains("swagger", StringComparison.OrdinalIgnoreCase) ?? false)
            && !(path.Value?.Contains("health", StringComparison.OrdinalIgnoreCase) ?? false))
        {
            // 进行基本的验证，例如检查请求的来源是否受信任，以及是否包含必要的参数
            if (!(await IsRequestValid(context.Request)))
            {
                context.Response.StatusCode = StatusCodes.Status403Forbidden;
                await context.Response.WriteAsync("无效的请求！");
                return;
            }
        }

        // 如果请求不是 /auth/login 或者验证通过，继续执行下一个中间件
        await _next.Invoke(context);
    }
    
    /// <summary>
    /// 验证token权限是否有效
    /// </summary>
    /// <param name="request"></param>
    /// <returns></returns>
    private async Task<bool> IsRequestValid(HttpRequest request)
    {
        try
        {
            // 获取请求头中的token
            var token = request.Headers["Authorization"].FirstOrDefault()?.Split(" ").Last();
            
            // 检查token是否有效
            if (string.IsNullOrEmpty(token))
            {
                return false;
            }
            
            // 获取token中的Claims信息
            var claims = new JwtSecurityToken(token).Claims;
            // 访问Redis验证用户是否黑名单
            
            // 如果token中存在授权ID 验证授权ID是否有效
            var authId = claims.FirstOrDefault(x => x.Type.Equals("AuthCode"))?.Value;
            if (authId.IsNotNullOrWhiteSpace())
            {
                
                var tenantAuthCode = await _dbService.Query<TenantAuthCode>(t => t.Id == authId.ToGuid());
                if (tenantAuthCode is null)
                {
                    return false;
                }
                
                // 验证授权ID是否过期
                if (tenantAuthCode.Validity < DateTime.Now)
                {
                    return false;
                }
                
                // 验证授权ID是否被禁用
                if (!tenantAuthCode.IsEnable)
                {
                    return false;
                }
                
                // 验证授权ID是否被删除
                if (tenantAuthCode.IsDelete)
                {
                    return false;
                }
                
                request.Headers.Append("AuthCode", authId);
            }
            // 都验证通过继续执行下一个中间件
            
            await Task.CompletedTask;
            return true;
        }
        catch (Exception e)
        {
            _logger.LogError(e.ToString());
            return false;
        }
    }
}