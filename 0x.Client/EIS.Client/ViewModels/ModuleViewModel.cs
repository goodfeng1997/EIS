using EIS.Infrastructure.ViewModels;
using Prism.Regions;

namespace EIS.Client.ViewModels
{
    public class ModuleViewModel : ViewModelBase, INavigationAware
    {
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
        #endregion

        /// <summary>
        /// 构造函数
        /// </summary>
        public ModuleViewModel() 
		{
   
        }

        #region 【命令】
        /// <summary>
        /// 登录命令
        /// </summary>
        /// <returns></returns>
        public bool LoginCommand()
		{

			return true;
		}
        #endregion

        #region 【导航命令】
        public void OnNavigatedTo(NavigationContext navigationContext)
        {
            
        }

        public bool IsNavigationTarget(NavigationContext navigationContext)
        {
            return false;
        }

        public void OnNavigatedFrom(NavigationContext navigationContext)
        {
            
        }
        #endregion
    }
}