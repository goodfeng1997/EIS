using System.Net;
using EIS.Shared.Enums;
using EIS.Shared.Response;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.Extensions.Logging;

namespace EIS.Core.Filter;

public class GlobalExceptionFilter : IExceptionFilter
{
    private readonly ILogger<GlobalExceptionFilter> _logger;
    
    /// <summary>
    /// 构造函数
    /// </summary>
    /// <param name="logger"></param>
    public GlobalExceptionFilter(ILogger<GlobalExceptionFilter> logger)
    {
        _logger = logger;
    }

    /// <summary>
    /// 触发异常
    /// </summary>
    /// <param name="filterContext"></param>
    public void OnException(ExceptionContext filterContext)
    {
        _logger.LogError(filterContext.Exception.ToString());
        var result = new Response
        {
            CodeEnum = ResponseCodeEnum.Exception,//系统异常代码
            Message= "系统异常，请联系管理员",//系统异常信息
        };
        filterContext.Result = new ObjectResult(result);
        filterContext.HttpContext.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
        filterContext.ExceptionHandled = true;
    }
}