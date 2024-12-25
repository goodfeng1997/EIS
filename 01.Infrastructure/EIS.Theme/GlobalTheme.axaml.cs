using Avalonia;
using Avalonia.Collections;
using Avalonia.Data;
using Avalonia.Markup.Xaml;
using Avalonia.Media;
using Avalonia.Styling;
using DynamicData;
using EIS.Infrastructure.Enums;
using EIS.Infrastructure.Models;
using EIS.Theme.Content;
using EIS.Theme.Extensions;

namespace EIS.Theme;

public class GlobalTheme : Styles
{
    public static readonly StyledProperty<ColorThemeEnum> ThemeColorProperty =
        AvaloniaProperty.Register<GlobalTheme, ColorThemeEnum>(nameof(Color), defaultBindingMode: BindingMode.OneTime,
            defaultValue: ColorThemeEnum.Blue);

    /// <summary>
    /// 颜色主题
    /// </summary>
    public ColorThemeEnum ThemeColor
    {
        get => GetValue(ThemeColorProperty);
        set
        {
            SetValue(ThemeColorProperty, value);
            SetColorThemeResourcesOnColorThemeChanged();
        }
    }

    /// <summary>
    /// 颜色主题更改事件
    /// </summary>
    public Action<ColorThemeModel>? OnColorThemeChanged { get; set; }

    /// <summary>
    /// 基础主题改变事件
    /// </summary>
    public Action<ThemeVariant>? OnBaseThemeChanged { get; set; }

    /// <summary>
    /// 背景动画改变事件
    /// </summary>
    public Action<bool>? OnBackgroundAnimationChanged { get; set; }

    /// <summary>
    /// 当前颜色主题
    /// </summary>
    public ColorThemeModel? ActiveColorTheme { get; private set; }

    /// <summary>
    /// 可使用的颜色主题
    /// </summary>
    public IAvaloniaReadOnlyList<ColorThemeModel> ColorThemes => _allThemes;

    /// <summary>
    /// 当前基础主题
    /// </summary>
    public ThemeVariant ActiveBaseTheme => _app.ActualThemeVariant;

    /// <summary>
    /// 是否启用背景动画
    /// </summary>
    public bool IsBackgroundAnimated => _background is { AnimationEnabled: true };

    private readonly Application _app;
    private readonly HashSet<ColorThemeModel> _colorThemeHashset = new();
    private readonly AvaloniaList<ColorThemeModel> _allThemes = new();
    private ThemeBackground? _background;

    /// <summary>
    /// 构造函数
    /// </summary>
    public GlobalTheme()
    {
        AvaloniaXamlLoader.Load(this);
        _app = Application.Current!;
        _app.ActualThemeVariantChanged += (_, _) => OnBaseThemeChanged?.Invoke(_app.ActualThemeVariant);
        foreach (var theme in DefaultColorThemes)
            AddColorTheme(theme.Value);
    }

    /// <summary>
    /// 更改颜色主题
    /// </summary>
    /// <param name="colorThemeEnum"></param>
    public void ChangeColorTheme(ColorThemeEnum colorThemeEnum) =>
        ThemeColor = colorThemeEnum;

    /// <summary>
    /// 更改颜色主题
    /// </summary>
    /// <param name="colorThemeModel"></param>
    public void ChangeColorTheme(ColorThemeModel colorThemeModel) =>
        SetColorTheme(colorThemeModel);

    /// <summary>
    /// 切换颜色主题
    /// </summary>
    public void SwitchColorTheme()
    {
        var index = ColorThemes.IndexOf(ActiveColorTheme);
        if (index == -1) return;
        var newIndex = (index + 1) % ColorThemes.Count;
        var newColorTheme = ColorThemes[newIndex];
        ChangeColorTheme(newColorTheme);
    }

    /// <summary>
    /// 添加颜色主题
    /// </summary>
    /// <param name="colorThemeModel"></param>
    /// <exception cref="InvalidOperationException"></exception>
    public void AddColorTheme(ColorThemeModel colorThemeModel)
    {
        if (!_colorThemeHashset.Add(colorThemeModel))
            throw new InvalidOperationException("This color theme has already been added.");
        _allThemes.Add(colorThemeModel);
    }

    /// <summary>
    /// 增加颜色主题（批量）
    /// </summary>
    /// <param name="colorThemeModels"></param>
    public void AddColorThemes(IEnumerable<ColorThemeModel> colorThemeModels)
    {
        foreach (var colorTheme in colorThemeModels)
            AddColorTheme(colorTheme);
    }

    /// <summary>
    /// 改变基础主题
    /// </summary>
    /// <param name="baseTheme"></param>
    public void ChangeBaseTheme(ThemeVariant baseTheme)
    {
        if (_app.ActualThemeVariant == baseTheme) return;
        _app.RequestedThemeVariant = baseTheme;
    }

    /// <summary>
    /// 改变基础主题
    /// </summary>
    public void SwitchBaseTheme()
    {
        if (Application.Current is null) return;
        var newBase = Application.Current.ActualThemeVariant == ThemeVariant.Dark
            ? ThemeVariant.Light
            : ThemeVariant.Dark;
        Application.Current.RequestedThemeVariant = newBase;
    }

    /// <summary>
    /// 设置背景动画使能
    /// </summary>
    /// <param name="value"></param>
    public void SetBackgroundAnimationsEnabled(bool value) =>
        _background?.SetAnimationEnabled(value);

    /// <summary>
    /// 切换背景动画使能
    /// </summary>
    public void SwitchBackgroundAnimationsEnabled() =>
        _background?.SetAnimationEnabled(_background.AnimationEnabled);

    /// <summary>
    /// 注册背景
    /// </summary>
    /// <param name="background"></param>
    internal void RegisterBackground(ThemeBackground background) =>
        _background ??= background;

    /// <summary>
    /// 初始化颜色主题资源
    /// </summary>
    /// <exception cref="Exception"></exception>
    private void SetColorThemeResourcesOnColorThemeChanged()
    {
        if (!DefaultColorThemes.TryGetValue(ThemeColor, out var colorTheme))
            throw new Exception($"{ThemeColor} has no defined color theme.");
        SetColorTheme(colorTheme);
    }

    /// <summary>
    /// 设置颜色主题
    /// </summary>
    /// <param name="colorTheme"></param>
    private void SetColorTheme(ColorThemeModel colorTheme)
    {
        SetColorWithOpacities("GlobalPrimaryColor", colorTheme.Primary);
        SetColorWithOpacities("GlobalAccentColor", colorTheme.Accent);
        ActiveColorTheme = colorTheme;
        OnColorThemeChanged?.Invoke(ActiveColorTheme);
    }

    /// <summary>
    /// 设置颜色主题透明度
    /// </summary>
    /// <param name="baseName"></param>
    /// <param name="baseColor"></param>
    private void SetColorWithOpacities(string baseName, Color baseColor)
    {
        SetResource(baseName, baseColor);
        SetResource($"{baseName}75", baseColor.WithAlpha(0.75));
        SetResource($"{baseName}50", baseColor.WithAlpha(0.50));
        SetResource($"{baseName}25", baseColor.WithAlpha(0.25));
        SetResource($"{baseName}15", baseColor.WithAlpha(0.15));
        SetResource($"{baseName}10", baseColor.WithAlpha(0.10));
        SetResource($"{baseName}7", baseColor.WithAlpha(0.07));
        SetResource($"{baseName}5", baseColor.WithAlpha(0.05));
        SetResource($"{baseName}3", baseColor.WithAlpha(0.03));
        SetResource($"{baseName}0", baseColor.WithAlpha(0.00));
    }

    /// <summary>
    /// 设置资源
    /// </summary>
    /// <param name="name"></param>
    /// <param name="color"></param>
    private void SetResource(string name, Color color) =>
        Application.Current!.Resources[name] = color;

    #region 静态成员

    /// <summary>
    /// 默认颜色主题
    /// </summary>
    public static readonly IReadOnlyDictionary<ColorThemeEnum, ColorThemeModel> DefaultColorThemes;

    /// <summary>
    /// 静态构造函数
    /// </summary>
    static GlobalTheme()
    {
        var defaultThemes = new[]
        {
            new DefaultColorThemeModel(ColorThemeEnum.Orange, Color.Parse("#ED8E12"), Color.Parse("#176CE8")),
            new DefaultColorThemeModel(ColorThemeEnum.Red, Color.Parse("#D03A2F"), Color.Parse("#2FC5D0")),
            new DefaultColorThemeModel(ColorThemeEnum.Green, Colors.ForestGreen, Color.Parse("#B24DB0")),
            new DefaultColorThemeModel(ColorThemeEnum.Blue, Color.Parse("#0A59F7"), Color.Parse("#F7A80A"))
        };
        DefaultColorThemes = defaultThemes.ToDictionary(x => x.ThemeColor, y => (ColorThemeModel)y);
    }

    /// <summary>
    /// 获取主题单例
    /// </summary>
    /// <param name="app"></param>
    /// <returns></returns>
    /// <exception cref="InvalidOperationException"></exception>
    public static GlobalTheme GetInstance(Application app)
    {
        var theme = app.Styles.FirstOrDefault(style => style is GlobalTheme);
        if (theme is not GlobalTheme GlobalTheme)
            throw new InvalidOperationException(
                "No GlobalTheme instance available. Ensure GlobalTheme has been set in Application.Styles in App.axaml.");
        return GlobalTheme;
    }

    /// <summary>
    /// 获取主题单例
    /// </summary>
    /// <returns></returns>
    public static GlobalTheme GetInstance() => GetInstance(Application.Current!);

    #endregion
}