using Avalonia.Media;
using EIS.Infrastructure.ViewModels;
using Prism.Services.Dialogs;

namespace EIS.Theme.Dialogs.ViewModels;

public class CustomThemeViewModel : ViewModelBase, IDialogAware
{
    #region 【属性】

    /// <summary>
    /// 展示名称
    /// </summary>
    private string _displayName = "Pink";

    public string DisplayName
    {
        get => _displayName;
        set => SetProperty(ref _displayName, value);
    }

    /// <summary>
    /// 主颜色
    /// </summary>
    private Color _primaryColor = Colors.DeepPink;

    public Color PrimaryColor
    {
        get => _primaryColor;
        set => SetProperty(ref _primaryColor, value);
    }

    /// <summary>
    /// 副颜色
    /// </summary>
    private Color _accentColor = Colors.Pink;

    public Color AccentColor
    {
        get => _accentColor;
        set => SetProperty(ref _accentColor, value);
    }

    #endregion
    
    /// <summary>
    /// 主题
    /// </summary>
    private readonly GlobalTheme _theme = GlobalTheme.GetInstance();

    public void TryCreateThemeCommand()
    {
        if (string.IsNullOrEmpty(DisplayName)) return;
        //var theme = new ColorThemeModel(DisplayName, PrimaryColor, AccentColor);
        //_theme.AddColorTheme(theme);
        //_theme.ChangeColorTheme(theme);
        //ThemeHost.CloseDialog();
        RequestClose?.Invoke(new DialogResult(ButtonResult.OK));
    }

    public void CloseDialogCommand()
    {
        
    }

    public bool CanCloseDialog()
    {
        return true;
    }

    public void OnDialogClosed()
    {
        
    }

    public void OnDialogOpened(IDialogParameters parameters)
    {
        //var _locator = Application.Current?.DataTemplates.FirstOrDefault();
        //ThemeHost.DialogContentProperty = _locator?.Build(this);
        //ThemeHost.ShowDialog(this, allowBackgroundClose: true);
    }

    public string Title { get; } = "自定义主题";
    public event Action<IDialogResult>? RequestClose;
}