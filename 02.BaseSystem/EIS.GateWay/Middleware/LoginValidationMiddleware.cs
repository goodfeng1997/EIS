using EIS.Core.Base.DataBaseLinq;
using EIS.Model.Base;
using EIS.Model.Dto;
using EIS.Shared.Extensions;

namespace EIS.GateWay.Middleware;
public class LoginValidationMiddleware
{
    private readonly RequestDelegate _next;
    private readonly IDbService _dbService;
    private readonly ILogger<LoginValidationMiddleware> _logger;

    /// <summary>
    /// 中间件构建函数
    /// </summary>
    /// <param name="next"></param>
    /// <param name="dbService"></param>
    /// <param name="logger"></param>
    public LoginValidationMiddleware(RequestDelegate next, 
        IDbService dbService,
        ILogger<LoginValidationMiddleware> logger)
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
        // 检查请求路径是否为 /auth/login登录路径
        if (context.Request.Path.Equals("/auth/login", StringComparison.OrdinalIgnoreCase))
        {
            // 进行基本的验证，例如检查请求的来源是否受信任，以及是否包含必要的参数
            if (!(await IsRequestValid(context.Request)))
            {
                context.Response.StatusCode = StatusCodes.Status400BadRequest;
                await context.Response.WriteAsync("无效的请求！");
                return;
            }
        }

        // 如果请求不是 /auth/login 或者验证通过，继续执行下一个中间件
        await _next.Invoke(context);
    }

    /// <summary>
    /// 验证请求是否有效
    /// </summary>
    /// <param name="request"></param>
    /// <returns></returns>
    private async Task<bool> IsRequestValid(HttpRequest request)
    {
        try
        {
            var clientId= request.Headers["ClientId"].ToString();
            var clientSecret= request.Headers["ClientSecret"].ToString();
            
            using var reader = new StreamReader(request.Body);
            var body = await reader.ReadToEndAsync();
            var model = body.FromJson<LoginRequestParam>();
            if (model is null)
            {
                return false;
            }
            // 验证客户端有效性
            var client = await _dbService.Query<EISClient>(t => t.ClientId == clientId && t.ClientSecret == clientSecret);
            
            if (client is null)
            {
                return false;
            }
            
            // 如果存在授权码，转换授权码为授权ID并放入请求参数内
            var authId = string.Empty;
            if (model.TenantAuth.IsNotNullOrWhiteSpace())
            {
                var authCode = await _dbService.Query<TenantAuthCode>(t => t.AuthCode == model.TenantAuth && t.IsEnable && !t.IsDelete);
            
                if (authCode is null)
                {
                    return false;
                }

                authId = authCode.Id.ToString();
            }

            // 增加验证参数/转换授权码
            Dictionary<string, string> dict = new Dictionary<string, string>
            {
                ["username"] = model.UserName,
                ["password"] = model.Password,
                ["client_id"] = clientId,
                ["client_secret"] = clientSecret,   
                ["grant_type"] = "password",
                ["authorization_code"] = authId
            };
            
            // 将表单数据转换为字节数组
            var formDataBytes = await (new FormUrlEncodedContent(dict)).ReadAsByteArrayAsync();
            
            // 更新请求内容
            request.Headers.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = formDataBytes.Length;
            
            // 将请求体写入请求流中
            var ms = new MemoryStream(formDataBytes);
            request.Body = ms;
            return true;
        }
        catch (Exception e)
        {
            _logger.LogError(e.ToString());
            return false;
        }
    }
}
