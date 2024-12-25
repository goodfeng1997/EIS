using EIS.Core.Base.DataBaseLinq;
using EIS.Model.Base;
using Microsoft.OpenApi.Models;

namespace EIS.GateWay.ServiceExtensions;

public static class SwaggerService
{
    private static readonly string apiVersion = "v1";
    private static readonly string apiDescription = "企业信息管理系统";
    private static List<EISApi> _apis = new();

    /// <summary>
    /// 增加Swagger服务
    /// </summary>
    /// <param name="services"></param>
    /// <param name="configuration"></param>
    /// <returns></returns>
    public static IServiceCollection AddSwaggerService(this IServiceCollection services,
        ConfigurationManager configuration)
    {
        services.AddScoped<IDbService>(provider =>
        {
            var dbService = provider.GetRequiredService<IDbService>();
            _apis = dbService.QueryList<EISApi>(t => t.IsEnable && !t.IsDelete).Result;

            services.AddSwaggerGen(option =>
            {
                _apis.ForEach(api =>
                {
                    option.SwaggerDoc(api.ApiCode,
                        new OpenApiInfo()
                            { Title = api.ApiDesc, Version = apiVersion, Description = apiDescription });
                });

                // 添加xml注释
                // 获取指定文件夹下的所有xml文件
                var xmlFiles = Directory.GetFiles(configuration["Swagger.Directory"] ?? "", "*.xml");

                foreach (var xmlFile in xmlFiles)
                {
                    option.IncludeXmlComments(xmlFile, true);
                }

                option.OrderActionsBy(o => o.RelativePath);
            });

            return dbService;
        });


        return services;
    }

    /// <summary>
    /// 使用swagger服务
    /// </summary>
    /// <param name="app"></param>
    /// <returns></returns>
    public static IApplicationBuilder UseSwaggerService(this IApplicationBuilder app)
    {
        app.UseSwagger();
        app.UseSwaggerUI(option =>
        {
            _apis.ForEach(api => { option.SwaggerEndpoint("/" + api.ApiCode + "/v1/swagger.json", api.ApiDesc); });
            option.RoutePrefix = ""; //路径配置，设置为空 表示直接在根域名(localhost:5000)访问该文件                
            option.DocumentTitle = "接口文档 - " + apiDescription; // API页面Title
            option.DefaultModelsExpandDepth(-1); // 模型的默认扩展深度，设置为 -1 完全隐藏模型                  
        });
        return app;
    }
}