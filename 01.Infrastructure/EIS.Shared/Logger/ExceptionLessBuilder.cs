using Exceptionless;
using Exceptionless.Logging;
using Microsoft.Extensions.DependencyInjection;

namespace EIS.Shared.Logger;

/// <summary>
/// ExceptionLessBuilder
/// </summary>
public static class ExceptionLessBuilder
{
    /// <summary>
    /// 添加ExceptionLess
    /// </summary>
    /// <param name="services"></param>
    /// <param name="apiKey"></param>
    /// <param name="serverUrl"></param>
    /// <param name="logLevel"></param>
    /// <returns></returns>
    public static IServiceCollection AddExceptionLess(this IServiceCollection services,
        string apiKey, string serverUrl, LogLevel logLevel = null)
    {
        ExceptionlessClient.Default.Configuration.ApiKey = apiKey;
        ExceptionlessClient.Default.Configuration.ServerUrl = serverUrl;
        ExceptionlessClient.Default.Configuration.SetDefaultMinLogLevel(logLevel ?? LogLevel.Trace);
           
        return services;
    }
}