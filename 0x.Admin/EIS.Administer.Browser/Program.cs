﻿using System.Runtime.Versioning;
using System.Threading.Tasks;

using Avalonia;
using Avalonia.Browser;
using Avalonia.ReactiveUI;

[assembly: SupportedOSPlatform("browser")]

namespace EIS.Administer.Browser;
internal partial class Program
{
    private static async Task Main(string[] args) => 
        await BuildAvaloniaApp()
        //.WithInterFont()
        .WithFont_SourceHanSansCN()
        .UseReactiveUI()
        .StartBrowserAppAsync("out");
    
    public static AppBuilder BuildAvaloniaApp()
        => AppBuilder.Configure<App>();
}
