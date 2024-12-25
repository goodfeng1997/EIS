using EIS.Client.Views;
using EIS.Infrastructure.Consts;
using EIS.Infrastructure.ViewModels;
using Prism.Regions;

namespace EIS.Client.ViewModels
{
    public class LoginViewModel : ViewModelBase, INavigationAware
    {
        #region�����ԡ�
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

        private readonly IRegionManager _regionManager;

        // /// <summary>
        // /// ���캯��
        // /// </summary>
        // public LoginViewModel() {}
        
        /// <summary>
        /// ���캯��
        /// </summary>
        public LoginViewModel(IRegionManager regionManager)
        {
            _regionManager = regionManager;
        }

        #region �����
        /// <summary>
        /// ��¼����
        /// </summary>
        /// <returns></returns>
        public bool LoginCommand()
		{
            _regionManager.RequestNavigate(RegionNameConst.MainRegionContent, nameof(ModuleView));

			return true;
		}
        #endregion

        #region ���������
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