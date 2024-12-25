using EIS.Core.ServiceExtensions;
using EIS.Shared.AppConfig;
using EIS.Shared.Logger;
using Hangfire;
using Hangfire.PostgreSql;

var builder = WebApplication.CreateBuilder(args);

// 添加配置文件
builder.Configuration.SetBasePath(Directory.GetCurrentDirectory())
    .AddJsonFile("appsettings.json", true, true);
    
// 添加Apollo
builder.Configuration.AddApolloConfiguration();

// 添加日志助手（分布式服务、Serilog）
builder.Services.AddExceptionLess(builder.Configuration["Exceptionless.ApiKey"], builder.Configuration["ExceptionLess.ServerUrl"]);
builder.Logging.AddSerilogConfiguration();

// 添加Url
builder.WebHost.ConfigureKestrel(options => { options.Limits.MaxRequestBodySize = int.MaxValue; })
    .UseKestrel()
    .UseUrls(
        $"{builder.Configuration["Service.HttpsMetadata"]}://{builder.Configuration["Listen.IP"]}:{builder.Configuration["Service.Port"]}",
        $"{builder.Configuration["Service.HttpsMetadata"]}://{builder.Configuration["Service.IP"]}:{builder.Configuration["Service.Port"]}");

// 注册nacos
//builder.Services.AddNacosAspNet(builder.Configuration);

// 添加Consul
builder.Services.AddConsulService(builder.Configuration);

builder.Services.AddHangfire(r => r.UsePostgreSqlStorage(option =>
{
    option.UseNpgsqlConnection(builder.Configuration["DataBase:Hangfire"]);
}));
builder.Services.AddHangfireServer();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
}

app.UseHttpsRedirection();

app.UseHangfireDashboard();

app.UseConsulCheckService();

app.Run();