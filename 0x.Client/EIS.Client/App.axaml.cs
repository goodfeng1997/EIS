using Avalonia;
using Avalonia.Controls.ApplicationLifetimes;
using Avalonia.Markup.Xaml;
using EIS.Client.BI;
using EIS.Client.CRM;
using EIS.Client.ERP;
using EIS.Client.HR;
using EIS.Client.ISMS;
using EIS.Client.KMS;
using EIS.Client.OA;
using EIS.Client.PLM;
using EIS.Client.SCM;
using EIS.Client.ViewModels;
using EIS.Client.Views;
using Prism.DryIoc;
using Prism.Ioc;
using Prism.Modularity;
using Prism.Services.Dialogs;

namespace EIS.Client;

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
        if (ApplicationLifetime is IClassicDesktopStyleApplicationLifetime desktop)
        {
            return Container.Resolve<MainWindow>();
        }
        else if (ApplicationLifetime is ISingleViewApplicationLifetime singleViewPlatform)
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

        // 注册对话框
        containerRegistry.RegisterDialogWindow<DialogWindow>();
    }

    /// <summary>
    /// 代码的方式添加模块，需要引用模块
    /// </summary>
    /// <param name="moduleCatalog"></param>
    protected override void ConfigureModuleCatalog(IModuleCatalog moduleCatalog)
    {
        moduleCatalog.AddModule<ERPModule>();
        moduleCatalog.AddModule<OAModule>();
        moduleCatalog.AddModule<HRModule>();
        moduleCatalog.AddModule<ISMSModule>();
        moduleCatalog.AddModule<KMSModule>();
        moduleCatalog.AddModule<PLMModule>();
        moduleCatalog.AddModule<SCMModule>();
        moduleCatalog.AddModule<CRMModule>();
        moduleCatalog.AddModule<BIModule>();

        base.ConfigureModuleCatalog(moduleCatalog);
    }
}
