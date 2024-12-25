using EIS.Client.Views;
using EIS.Infrastructure.Consts;
using EIS.Infrastructure.ViewModels;
using Prism.Regions;

namespace EIS.Client.ViewModels;

public class MainWindowViewModel : ViewModelBase
{
    public MainWindowViewModel(IRegionManager regionManager)
    {
        regionManager.RegisterViewWithRegion(RegionNameConst.MainRegionContent, nameof(LoginView));
    }
}
