using System.Threading.Tasks;
using EIS.Administer.Views;
using EIS.Infrastructure.Consts;
using EIS.Infrastructure.ViewModels;
using Prism.Regions;

namespace EIS.Administer.ViewModels;

public class LoginViewModel : ViewModelBase
{
    private readonly IRegionManager? _regionManager;

    /// <summary>
    /// 构造函数
    /// </summary>
    public LoginViewModel() { }
    
    /// <summary>
    /// 构造函数
    /// </summary>
    /// <param name="regionManager"></param>
    public LoginViewModel(IRegionManager regionManager)
    {
        _regionManager = regionManager;
    }

    #region【属性】
    private string _userName = string.Empty;
    public string UserName
    {
        get => _userName;
        set => SetProperty(ref _userName, value);
    }

    private string _passWord = string.Empty;
    public string PassWord
    {
        get => _passWord;
        set => SetProperty(ref _passWord, value);
    }
    
    private bool _isLoggingIn = false;
    public bool IsLoggingIn
    {
        get => _isLoggingIn;
        set => SetProperty(ref _isLoggingIn, value);
    }
    #endregion
    
    #region 【命令】
    /// <summary>
    /// 登录命令
    /// </summary>
    /// <returns></returns>
    public async Task<bool> LoginCommand()
    {
        IsLoggingIn = true;
        await Task.Delay(2000);
        _regionManager?.RequestNavigate(RegionNameConst.MainRegionContent, nameof(ModuleView));
        IsLoggingIn = false;

        return true;
    }
    #endregion
}