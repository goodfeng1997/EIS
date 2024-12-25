using EIS.Core.Base.DataBaseLinq;
using EIS.Model.Base;
using IdentityServer4.AccessTokenValidation;

namespace EIS.GateWay.ServiceExtensions;

public static class AuthenticationService
{
    /// <summary>
    /// 添加IdentityServer4的认证服务
    /// </summary>
    /// <param name="services"></param>
    /// <param name="configurationManager"></param>
    /// <returns></returns>
    public static IServiceCollection AddAuthenticationService(this IServiceCollection services,
        ConfigurationManager configurationManager)
    {
        services.AddScoped<IDbService>(provider =>
        {
            var dbService = provider.GetRequiredService<IDbService>();
            var apiList = dbService.QueryList<EISApi>(t => !t.IsDelete && t.IsEnable);
            foreach (var api in apiList.Result)
            {
                // JwtBearerDefaults.AuthenticationScheme
                services.AddAuthentication()
                    .AddIdentityServerAuthentication(api.ApiName, options =>
                    {
                        options.Authority = configurationManager["IdentityServer.Url"]; //id4服务地址
                        options.ApiName = api.ApiName; //id4 api资源里的ApiName
                        options.RequireHttpsMetadata = false; //不使用https
                        options.SupportedTokens = SupportedTokens.Both;
                        options.ApiSecret = api.ApiName; //id4 api资源里的ApiSecret
                    });
            }

            return dbService;
        });
        return services;
    }
}