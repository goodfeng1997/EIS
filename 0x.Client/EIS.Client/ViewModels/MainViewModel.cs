using EIS.Client.Views;
using EIS.Infrastructure.Consts;
using EIS.Infrastructure.ViewModels;
using Prism.Regions;

namespace EIS.Client.ViewModels;

public class MainViewModel : ViewModelBase
{
    public MainViewModel(IRegionManager regionManager)
    {
        regionManager.RegisterViewWithRegion(RegionNameConst.MainRegionContent, nameof(LoginView));
    }
}
