using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.OpenApi.Models;

namespace EIS.Core.ServiceExtensions;

public static class SwaggerBuilder
{
    /// <summary>
    /// 添加Swagger服务
    /// </summary>
    /// <param name="services"></param>
    /// <param name="configuration"></param>
    /// <param name="swaggerFileName"></param>
    /// <returns></returns>
    public static IServiceCollection AddSwaggerService(this IServiceCollection services, ConfigurationManager configuration,
        string swaggerFileName = "")
    {
        services.AddSwaggerGen(option =>
        {
            var xmlFile = Path.Combine(configuration["Swagger.Directory"] ?? "", swaggerFileName);
            option.IncludeXmlComments(xmlFile, true);

            option.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
            {
                Name = "Authorization",
                Description = "请输入token，格式: \"Authorization: Bearer {token}\"",
                In = ParameterLocation.Header,
                Type = SecuritySchemeType.ApiKey,
                Scheme = "Bearer",
                BearerFormat = "JWT"
            });
            option.AddSecurityRequirement(new OpenApiSecurityRequirement
            {
                {
                    new OpenApiSecurityScheme
                    {
                        Reference = new OpenApiReference
                        {
                            Type = ReferenceType.SecurityScheme,
                            Id = "Bearer"
                        }
                    },
                    new string[] { }
                }
            });
        });
        return services;
    }

    /// <summary>
    /// 使用Swagger服务
    /// </summary>
    /// <param name="app"></param>
    /// <param name="configuration"></param>
    /// <param name="routeTemplate"></param>
    /// <param name="url"></param>
    /// <returns></returns>
    public static IApplicationBuilder UseSwaggerService(this IApplicationBuilder app,
        ConfigurationManager configuration, string routeTemplate = "", string url = "")
    {
        app.UseSwagger(options => { options.RouteTemplate = routeTemplate; });
        app.UseSwaggerUI(action =>
        {
            action.RoutePrefix = "";
            action.SwaggerEndpoint(url,
                $"{configuration["Service.Name"]} {configuration["Service.Version"]}");
        });
        return app;
    }
}