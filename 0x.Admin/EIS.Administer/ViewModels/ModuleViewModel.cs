using System.Threading.Tasks;
using Avalonia.Collections;
using EIS.Administer.Base.Views;
using EIS.Administer.Tenant.Views;
using EIS.Infrastructure.Consts;
using EIS.Infrastructure.Models;
using EIS.Infrastructure.ViewModels;
using EIS.Theme.Pages.Views;
using Material.Icons;
using Prism.Regions;

namespace EIS.Administer.ViewModels;

public class ModuleViewModel : ViewModelBase
{
    private readonly IRegionManager? _regionManager;

    #region 【属性】

    /// <summary>
    /// 当前选中菜单
    /// </summary>
    private MenuItemModel? _activeMenu;

    public MenuItemModel? ActiveMenu
    {
        get => _activeMenu;
        set
        {
            if (Equals(value, _activeMenu)) return;
            _regionManager?.RequestNavigate(RegionNameConst.ContentRegionContent, value?.MenuCode);
            SetProperty(ref _activeMenu, value);
        }
    }

    public IAvaloniaReadOnlyList<MenuItemModel>? MenuItems { get; }

    #endregion

    /// <summary>
    /// 构造函数
    /// </summary>
    public ModuleViewModel()
    {
    }

    /// <summary>
    /// 构造函数
    /// </summary>
    public ModuleViewModel(IRegionManager regionManager)
    {
        _regionManager = regionManager;
        MenuItems = new AvaloniaList<MenuItemModel>
        {
            new()
            {
                MenuCode = nameof(BaseManageView), DisplayName = "基础信息", Icon = MaterialIconKind.About, Index = 1
            },
            new()
            {
                MenuCode = nameof(TenantManageView), DisplayName = "租户管理", Icon = MaterialIconKind.Users, Index = 2
            },
            new()
            {
                MenuCode = nameof(SettingManageView), DisplayName = "系统设置", Icon = MaterialIconKind.Settings, Index = 3
            }
        };
    }


    /// <summary>
    /// 打开菜单
    /// </summary>
    /// <returns></returns>
    public async Task OpenMenuCommand()
    {
        _regionManager?.RequestNavigate(RegionNameConst.ContentRegionContent, nameof(ThemeView));
        await Task.CompletedTask;
    }
}