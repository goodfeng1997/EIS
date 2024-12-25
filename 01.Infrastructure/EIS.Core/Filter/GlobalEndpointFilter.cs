using Microsoft.AspNetCore.Http;

namespace EIS.Core.Filter;

public class GlobalEndpointFilter : IEndpointFilter
{
    private readonly RequestDelegate _next;
    /// <summary>
    /// 构造函数
    /// </summary>
    /// <param name="next"></param>
    public GlobalEndpointFilter(RequestDelegate next)
    {
        _next = next;
    }
    
    /// <summary>
    /// 触发函数
    /// </summary>
    /// <param name="context"></param>
    /// <param name="next"></param>
    /// <returns></returns>
    public async ValueTask<object?> InvokeAsync(EndpointFilterInvocationContext context, EndpointFilterDelegate next)
    {
        context.HttpContext.Response.Headers["net-version"] = System.Runtime.InteropServices.RuntimeInformation.FrameworkDescription;
        return await next(context);
    }
}