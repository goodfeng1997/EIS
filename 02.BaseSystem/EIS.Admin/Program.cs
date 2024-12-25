using EIS.Core.Filter;
using EIS.Core.ServiceExtensions;
using EIS.Shared.AppConfig;
using EIS.Shared.Logger;

var builder = WebApplication.CreateBuilder(args);

// 添加配置文件
builder.Configuration.SetBasePath(Directory.GetCurrentDirectory())
    .AddJsonFile("appsettings.json", true, true);
    
// 添加Apollo
builder.Configuration.AddApolloConfiguration();

// 添加日志助手（分布式服务、Serilog）
builder.Services.AddExceptionLess(builder.Configuration["Exceptionless.ApiKey"], builder.Configuration["ExceptionLess.ServerUrl"]);
builder.Logging.AddSerilogConfiguration();

// 添加数据库连接
builder.Services.AddAppDatabase(builder.Configuration);

// 添加Url
builder.WebHost.ConfigureKestrel(options => { options.Limits.MaxRequestBodySize = int.MaxValue; })
    .UseKestrel()
    .UseUrls(
        $"{builder.Configuration["Service.HttpsMetadata"]}://{builder.Configuration["Listen.IP"]}:{builder.Configuration["Service.Port"]}",
        $"{builder.Configuration["Service.HttpsMetadata"]}://{builder.Configuration["Service.IP"]}:{builder.Configuration["Service.Port"]}");

// 注册nacos
//builder.Services.AddNacosAspNet(builder.Configuration);

// 注册consul
builder.Services.AddConsulService(builder.Configuration);

// 添加Cors
builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(p => p.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod());
});

// 添加控制器
builder.Services.AddControllers(option =>
{
    option.Filters.Add<GlobalExceptionFilter>();
    option.Filters.Add<GlobalResponseFilter>();
});

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerService(builder.Configuration, "EIS.Admin.xml");

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
}

app.UseTenantDatabase();

app.UseSwaggerService(builder.Configuration, "admin/{documentName}/swagger.json", "/admin/v1/swagger.json");

app.UseHttpsRedirection();

app.UseCors(p => p.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod());

app.UseRouting();

app.UseConsulCheckService();

app.MapControllers();

app.Run();