using Avalonia.Collections;
using Avalonia.Styling;
using EIS.Infrastructure.Models;
using EIS.Infrastructure.ViewModels;
using EIS.Theme.Dialogs.Views;
using Prism.Commands;
using Prism.Services.Dialogs;

namespace EIS.Theme.Pages.ViewModels;

public class ThemeViewModel : ViewModelBase
{
    #region 【属性】

    /// <summary>
    /// 是否使用浅色主题
    /// </summary>
    private bool _isLightTheme;

    public bool IsLightTheme
    {
        get => _isLightTheme;
        set
        {
            if (!EqualityComparer<bool>.Default.Equals(_isLightTheme, value))
            {
                _theme.ChangeBaseTheme(value ? ThemeVariant.Light : ThemeVariant.Dark);
                SetProperty(ref _isLightTheme, value);
            }
        }
    }

    #endregion

    /// <summary>
    /// 主题
    /// </summary>
    private readonly GlobalTheme _theme = GlobalTheme.GetInstance();

    /// <summary>
    /// 主题列表
    /// </summary>
    public IAvaloniaReadOnlyList<ColorThemeModel> AvailableColors { get; }
    
    /// <summary>
    /// 弹窗服务
    /// </summary>
    private readonly IDialogService _dialogService;

    /// <summary>
    /// 构造函数
    /// </summary>
    public ThemeViewModel(IDialogService dialogService)
    {
        AvailableColors = _theme.ColorThemes;
        IsLightTheme = _theme.ActiveBaseTheme == ThemeVariant.Light;
        _theme.OnBaseThemeChanged += variant =>
            IsLightTheme = variant == ThemeVariant.Light;

        _dialogService = dialogService;
    }

    #region 【命令】

    /// <summary>
    /// 切换颜色主题
    /// </summary>
    private DelegateCommand<ColorThemeModel?>? _switchToColorThemeCommand;
    public DelegateCommand<ColorThemeModel?> SwitchToColorThemeCommand =>
        _switchToColorThemeCommand ??= new DelegateCommand<ColorThemeModel?>(
            (colorTheme) =>
            {
                _theme.ChangeColorTheme(colorTheme ?? _theme.ColorThemes.First());
            });

    /// <summary>
    /// 创造自定义主题
    /// </summary>
    public void CreateCustomThemeCommand()
    {
        _dialogService.ShowDialog(nameof(CustomThemeView), new DialogParameters(), (r) =>
        {
            Console.WriteLine(r.Result);
        });
        //ThemeHost.ShowDialog(new CustomThemeViewModel(), allowBackgroundClose: true);
    }

    #endregion
}