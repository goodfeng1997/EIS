using Microsoft.AspNetCore.Mvc.Filters;

namespace EIS.Core.Attribute;

[AttributeUsage(AttributeTargets.Field, AllowMultiple = false, Inherited = true)]
public class RabbitMqAttribute : System.Attribute,IAsyncActionFilter
{
    public RabbitMqAttribute()
    {
        
    }

    /// <summary>
    /// 执行调用
    /// </summary>
    /// <param name="context"></param>
    /// <param name="next"></param>
    public async Task OnActionExecutionAsync(ActionExecutingContext context, ActionExecutionDelegate next)
    {
        await Task.CompletedTask;
    }
}