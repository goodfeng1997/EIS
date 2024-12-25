using EIS.Administer.Views;
using EIS.Infrastructure.Consts;
using EIS.Infrastructure.ViewModels;
using Prism.Regions;

namespace EIS.Administer.ViewModels;

public partial class MainViewModel : ViewModelBase
{
    private readonly IRegionManager _regionManager;
    public MainViewModel(IRegionManager regionManager)
    {
        _regionManager = regionManager;
        _regionManager.RegisterViewWithRegion(RegionNameConst.MainRegionContent, nameof(LoginView));
    }
}
