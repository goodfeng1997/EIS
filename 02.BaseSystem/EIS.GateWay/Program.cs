using EIS.Core.Filter;
using EIS.Core.ServiceExtensions;
using EIS.GateWay.Middleware;
using EIS.GateWay.ServiceExtensions;
using EIS.Shared.AppConfig;
using EIS.Shared.Logger;
using Ocelot.DependencyInjection;
using Ocelot.Middleware;
using Ocelot.Provider.Consul;
using Ocelot.Provider.Polly;

var builder = WebApplication.CreateBuilder(args);

// 添加配置文件
builder.Configuration.SetBasePath(Directory.GetCurrentDirectory())
    .AddJsonFile("appsettings.json", true, true)
    .AddJsonFile("ocelot.json", optional: false, reloadOnChange: true);

// 添加Apollo
builder.Configuration.AddApolloConfiguration();

// 添加日志助手（分布式服务、Serilog）
builder.Services.AddExceptionLess(builder.Configuration["Exceptionless.ApiKey"], builder.Configuration["ExceptionLess.ServerUrl"]);
builder.Logging.AddSerilogConfiguration();

// 添加数据库连接
builder.Services.AddAppDatabase(builder.Configuration);

// 设置请求Url
builder.WebHost.ConfigureKestrel(options => { options.Limits.MaxRequestBodySize = int.MaxValue; })
    .UseKestrel()
    .UseUrls(
        $"{builder.Configuration["Service.HttpsMetadata"]}://{builder.Configuration["Listen.IP"]}:{builder.Configuration["Service.Port"]}",
        $"{builder.Configuration["Service.HttpsMetadata"]}://{builder.Configuration["Service.IP"]}:{builder.Configuration["Service.Port"]}");

// 添加Nacos
//builder.Services.AddNacosAspNet(builder.Configuration);

// 添加Consul
builder.Services.AddConsulService(builder.Configuration);

// 添加Cors
builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(p => p.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod());
});

// 添加Ocelot
builder.Services.AddOcelot().AddConsul().AddPolly();

// 添加控制器
builder.Services.AddControllers(option =>
{
    option.Filters.Add<GlobalExceptionFilter>();
    option.Filters.Add<GlobalResponseFilter>();
});

// 添加认证服务
builder.Services.AddAuthenticationService(builder.Configuration);

// 添加Swagger
builder.Services.AddEndpointsApiExplorer(); 
builder.Services.AddSwaggerService(builder.Configuration);

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
    app.UseSwaggerService();
}

app.UseMiddleware<LoginValidationMiddleware>();

app.UseMiddleware<TokenValidationMiddleware>();

app.UseHttpsRedirection();

app.UseCors(p => p.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod());

//app.UseNacosAspNet(app.Lifetime).Wait();

app.UseConsulCheckService();

app.UseOcelot((action, pipelineConfiguration) =>
{
    action.BuildCustomOcelotPipeline(pipelineConfiguration);
}).Wait();

app.Run();

