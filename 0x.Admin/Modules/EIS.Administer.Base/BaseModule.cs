using Prism.Ioc;
using Prism.Modularity;
using EIS.Administer.Base.ViewModels;
using EIS.Administer.Base.Views;

namespace EIS.Administer.Base
{
    public class BaseModule : IModule
    {
        public void OnInitialized(IContainerProvider containerProvider)
        {
            
        }

        public void RegisterTypes(IContainerRegistry containerRegistry)
        {
            containerRegistry.RegisterForNavigation<BaseManageView, BaseManageViewModel>(nameof(BaseManageView));
        }
    }
}
