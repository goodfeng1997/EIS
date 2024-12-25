using System.Globalization;
using System.Threading.RateLimiting;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.RateLimiting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace EIS.Core.ServiceExtensions;

public static class RateLimiterBuilder
{
    /// <summary>
    /// 添加限流服务
    /// </summary>
    /// <param name="services"></param>
    /// <param name="configuration"></param>
    /// <param name="limiterType"></param>
    /// <returns></returns>
    public static IServiceCollection AddRateLimiterService(this IServiceCollection services, IConfiguration configuration, int limiterType = 0)
    {
        services.AddRateLimiter(option =>
        {
            option.RejectionStatusCode = StatusCodes.Status429TooManyRequests;
            if (limiterType == 1)
            {
                // 固定窗口限流
                option.AddFixedWindowLimiter(policyName: "Default", options =>
                {
                    options.Window = TimeSpan.FromSeconds(60);
                    options.PermitLimit = 60;
                    options.QueueProcessingOrder = QueueProcessingOrder.OldestFirst;
                    options.QueueLimit = 10;
                    options.AutoReplenishment = true;
                });
            }
            else if (limiterType == 2)
            {
                // 滑动窗口限流
                option.AddSlidingWindowLimiter(policyName: "Default", options =>
                {
                    options.Window = TimeSpan.FromSeconds(60);
                    options.PermitLimit = 60;
                    options.QueueProcessingOrder = QueueProcessingOrder.OldestFirst;
                    options.QueueLimit = 10;
                    options.AutoReplenishment = true;
                    options.SegmentsPerWindow = 10;
                });
            }
            else if (limiterType == 3)
            {
                // 令牌限流
                option.AddTokenBucketLimiter(policyName: "Default", options =>
                {
                    options.ReplenishmentPeriod = TimeSpan.FromSeconds(60);
                    options.TokenLimit = 60;
                    options.TokensPerPeriod = 60;
                    options.QueueLimit = 10;
                    options.QueueProcessingOrder = QueueProcessingOrder.OldestFirst;
                    options.AutoReplenishment = true;
                });
            }
            else if (limiterType == 4)
            {
                // 并发限流
                option.AddConcurrencyLimiter(policyName: "Default", options =>
                {
                    options.PermitLimit = 4;
                    options.QueueProcessingOrder = QueueProcessingOrder.OldestFirst;
                    options.QueueLimit = 2;
                });
            }
            
            // 设置自定义响应
            option.OnRejected = (context, token) =>
            {
                if (context.Lease.TryGetMetadata(MetadataName.RetryAfter, out var retryAfter))
                {
                    context.HttpContext.Response.Headers.RetryAfter =
                        ((int)retryAfter.TotalSeconds).ToString(NumberFormatInfo.InvariantInfo);
                }
                
                context.HttpContext.Response.StatusCode = StatusCodes.Status429TooManyRequests;

                return ValueTask.CompletedTask;   
            };
        });
        return services;
    }
}