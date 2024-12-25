using EIS.Shared.Enums;
using EIS.Shared.Extensions;
using EIS.Shared.Response;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace EIS.Core.Filter;

public class GlobalResponseFilter : IAsyncResultFilter
{
    /// <summary>
    /// 封装结果返回
    /// </summary>
    /// <param name="context"></param>
    /// <param name="next"></param>
    /// <returns></returns>
    /// <exception cref="NotImplementedException"></exception>
    public async Task OnResultExecutionAsync(ResultExecutingContext context, ResultExecutionDelegate next)
    {
        if (context.Result is ObjectResult objectResult)
        {
            if (objectResult.Value is Response response)
            {
                objectResult.StatusCode = response.CodeEnum.TryToInt();
                context.HttpContext.Response.StatusCode = response.CodeEnum.TryToInt();
            }
            else
            {
                var statusCode = objectResult.StatusCode ?? context.HttpContext.Response.StatusCode;

                var result = new Response<object?>
                {
                    CodeEnum = (ResponseCodeEnum)statusCode,
                    Successful = statusCode is >= 200 and < 400,
                    Result = objectResult.Value ?? null,
                };

                objectResult.Value = result;
                objectResult.DeclaredType = result.GetType();
            }
        }

        await next();
    }
}