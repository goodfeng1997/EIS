using Com.Ctrip.Framework.Apollo;
using Microsoft.Extensions.Configuration;

namespace EIS.Shared.AppConfig;

/// <summary>
/// Apollo配置构建器
/// </summary>
public static class ApolloBuilder
{
    /// <summary>
    /// 导入Apollo配置
    /// </summary>
    /// <param name="configuration"></param>
    /// <returns></returns>
    public static ConfigurationManager AddApolloConfiguration(this ConfigurationManager configuration)
    {
        configuration.AddApollo(configuration.GetSection("Apollo"))
            .AddDefault()
            .AddNamespace(configuration["Apollo:Namespace"] ?? "");
        return configuration;
    }
}