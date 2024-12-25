using Prism.Ioc;
using Prism.Modularity;
using EIS.Administer.Tenant.ViewModels;
using EIS.Administer.Tenant.Views;

namespace EIS.Administer.Setting
{
    public class SettingModule : IModule
    {
        public void OnInitialized(IContainerProvider containerProvider)
        {
            
        }

        public void RegisterTypes(IContainerRegistry containerRegistry)
        {
            containerRegistry.RegisterForNavigation<SettingManageView, SettingManageViewModel>(nameof(SettingManageView));
        }
    }
}
