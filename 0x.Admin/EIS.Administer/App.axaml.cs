using Avalonia;
using Avalonia.Controls.ApplicationLifetimes;
using Avalonia.Markup.Xaml;
using EIS.Administer.Base;
using EIS.Administer.Setting;
using EIS.Administer.Tenant;
using EIS.Administer.ViewModels;
using EIS.Administer.Views;
using EIS.Theme.Controls;
using EIS.Theme.Dialogs.ViewModels;
using EIS.Theme.Dialogs.Views;
using EIS.Theme.Pages.ViewModels;
using EIS.Theme.Pages.Views;
using Prism.DryIoc;
using Prism.Ioc;
using Prism.Modularity;

namespace EIS.Administer;

public partial class App : PrismApplication
{
    /// <summary>
    /// 应用初始化
    /// </summary>
    public override void Initialize()
    {
        AvaloniaXamlLoader.Load(this);
        base.Initialize();
    }

    /// <summary>
    /// 创建Shell
    /// </summary>
    /// <returns></returns>
    protected override AvaloniaObject CreateShell()
    {
        if (ApplicationLifetime is IClassicDesktopStyleApplicationLifetime)
        {
            return Container.Resolve<MainWindow>();
        }
        else if (ApplicationLifetime is ISingleViewApplicationLifetime)
        {
            return Container.Resolve<MainView>();
        }
        return Container.Resolve<MainWindow>();
    }
    
    /// <summary>
    /// 加载完成
    /// </summary>
    public override void OnFrameworkInitializationCompleted()
    {
        base.OnFrameworkInitializationCompleted();
    }
    
    /// <summary>
    /// 注册服务
    /// </summary>
    /// <param name="containerRegistry"></param>
    protected override void RegisterTypes(IContainerRegistry containerRegistry)
    {
        // 注册导航
        containerRegistry.RegisterForNavigation<LoginView, LoginViewModel>(nameof(LoginView));
        containerRegistry.RegisterForNavigation<ModuleView, ModuleViewModel>(nameof(ModuleView));
        containerRegistry.RegisterForNavigation<ThemeView, ThemeViewModel>(nameof(ThemeView));
        containerRegistry.RegisterDialog<CustomThemeView, CustomThemeViewModel>(nameof(CustomThemeView));
        
        // 注册对话框
        containerRegistry.RegisterDialogWindow<ThemeDialog>();
    }

    /// <summary>
    /// 代码的方式添加模块，需要引用模块
    /// </summary>
    /// <param name="moduleCatalog"></param>
    protected override void ConfigureModuleCatalog(IModuleCatalog moduleCatalog)
    {
        moduleCatalog.AddModule<BaseModule>();
        moduleCatalog.AddModule<TenantModule>();
        moduleCatalog.AddModule<SettingModule>();
        base.ConfigureModuleCatalog(moduleCatalog);
    }
}
