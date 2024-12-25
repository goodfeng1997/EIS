using Prism.Ioc;
using Prism.Modularity;
using EIS.Administer.Tenant.ViewModels;
using EIS.Administer.Tenant.Views;

namespace EIS.Administer.Tenant
{
    public class TenantModule : IModule
    {
        public void OnInitialized(IContainerProvider containerProvider)
        {
            
        }

        public void RegisterTypes(IContainerRegistry containerRegistry)
        {
            containerRegistry.RegisterForNavigation<TenantManageView, TenantManageViewModel>(nameof(TenantManageView));
        }
    }
}
