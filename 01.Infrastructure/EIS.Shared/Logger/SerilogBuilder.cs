using System.Text;
using Microsoft.Extensions.Logging;
using Serilog;

namespace EIS.Shared.Logger;

/// <summary>
/// serilog 配置
/// </summary>
public static class SerilogBuilder
{
    /// <summary>
    /// 添加serilog
    /// </summary>
    /// <param name="loggingBuilder"></param>
    /// <param name="apolloConsoleLog"></param>
    /// <returns></returns>
    public static ILoggingBuilder AddSerilogConfiguration(this ILoggingBuilder loggingBuilder, bool apolloConsoleLog = false)
    {
        loggingBuilder.ClearProviders();
        Log.Logger = new LoggerConfiguration()
            .MinimumLevel.Debug()
            .Enrich.FromLogContext()
            .WriteTo.File($"logs/{DateTime.Now:yyyy-MM-dd}/log.txt", //日志按照天为单位创建文件夹
                outputTemplate:
                @"{Timestamp:yyyy-MM-dd HH:mm-ss.fff }[{Level:u3}] {Message:lj}{NewLine}{Exception}", // 设置输出格式，显示详细异常信息
                rollingInterval: RollingInterval.Day, //日志按天保存
                rollOnFileSizeLimit: true, // 限制单个文件的最大长度
                fileSizeLimitBytes: 10240 * 1024, // 单个文件最大长度10K
                encoding: Encoding.UTF8, // 文件字符编码
                retainedFileCountLimit: 100 // 最大保存文件数,超过最大文件数会自动覆盖原有文件
            )
            .WriteTo.Console()  //new JsonFormatter()
            .WriteTo.Exceptionless()   // 写入Exceptionless
            .CreateLogger();
        loggingBuilder.AddSerilog().AddConsole();
        if (apolloConsoleLog)
        {
            Com.Ctrip.Framework.Apollo.Logging.LogManager.UseConsoleLogging(Com.Ctrip.Framework.Apollo.Logging.LogLevel.Trace);
        }
        return loggingBuilder;
    }
}