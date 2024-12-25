using System.Reactive;
using System.Reactive.Linq;
using Avalonia;
using Avalonia.Controls;
using Avalonia.Controls.ApplicationLifetimes;
using Avalonia.Controls.Primitives;
using Avalonia.Input;
using Avalonia.Interactivity;
using Avalonia.Media;
using Avalonia.Threading;
using EIS.Theme.Content;
using Prism.Services.Dialogs;

namespace EIS.Theme.Controls;

public class ThemeDialog : Window, IDialogWindow
{
    protected override Type StyleKeyOverride => typeof(ThemeDialog);

    public IDialogResult Result { get; set; } = new DialogResult();

    #region 弹窗标题栏

    public static readonly StyledProperty<bool> IsWindowToolVisibleProperty =
        AvaloniaProperty.Register<ThemeDialog, bool>(nameof(IsWindowToolVisible), defaultValue: true);

    public bool IsWindowToolVisible
    {
        get => GetValue(IsWindowToolVisibleProperty);
        set => SetValue(IsWindowToolVisibleProperty, value);
    }

    public static readonly StyledProperty<bool> ShowBottomBorderProperty =
        AvaloniaProperty.Register<ThemeDialog, bool>(nameof(ShowBottomBorder), defaultValue: true);

    public bool ShowBottomBorder
    {
        get => GetValue(ShowBottomBorderProperty);
        set => SetValue(ShowBottomBorderProperty, value);
    }

    public static readonly StyledProperty<bool> CanMinimizeProperty =
        AvaloniaProperty.Register<ThemeDialog, bool>(nameof(CanMinimize), defaultValue: false);

    public bool CanMinimize
    {
        get => GetValue(CanMinimizeProperty);
        set => SetValue(CanMinimizeProperty, value);
    }

    public static readonly StyledProperty<bool> CanMoveProperty =
        AvaloniaProperty.Register<ThemeDialog, bool>(nameof(CanMove), defaultValue: true);

    public bool CanMove
    {
        get => GetValue(CanMoveProperty);
        set => SetValue(CanMoveProperty, value);
    }

    #endregion

    #region 弹窗标题

    public static readonly StyledProperty<bool> IsTitleBarVisibleProperty =
        AvaloniaProperty.Register<ThemeDialog, bool>(nameof(IsTitleBarVisible), defaultValue: true);

    public bool IsTitleBarVisible
    {
        get => GetValue(IsTitleBarVisibleProperty);
        set => SetValue(IsTitleBarVisibleProperty, value);
    }

    public static readonly StyledProperty<double> TitleFontSizeProperty =
        AvaloniaProperty.Register<ThemeDialog, double>(nameof(TitleFontSize), defaultValue: 13);

    public double TitleFontSize
    {
        get => GetValue(TitleFontSizeProperty);
        set => SetValue(TitleFontSizeProperty, value);
    }

    public static readonly StyledProperty<FontWeight> TitleFontWeightProperty =
        AvaloniaProperty.Register<ThemeDialog, FontWeight>(nameof(TitleFontWeight),
            defaultValue: FontWeight.Bold);

    public FontWeight TitleFontWeight
    {
        get => GetValue(TitleFontWeightProperty);
        set => SetValue(TitleFontWeightProperty, value);
    }

    public static readonly StyledProperty<Control?> LogoContentProperty =
        AvaloniaProperty.Register<ThemeDialog, Control?>(nameof(LogoContent));

    public Control? LogoContent
    {
        get => GetValue(LogoContentProperty);
        set => SetValue(LogoContentProperty, value);
    }

    #endregion

    public static readonly StyledProperty<bool> BackgroundAnimationEnabledProperty =
        AvaloniaProperty.Register<ThemeDialog, bool>(nameof(BackgroundAnimationEnabled), defaultValue: false);

    public bool BackgroundAnimationEnabled
    {
        get => GetValue(BackgroundAnimationEnabledProperty);
        set => SetValue(BackgroundAnimationEnabledProperty, value);
    }

    private IDisposable? _subscriptionDisposables;

    protected override void OnLoaded(RoutedEventArgs e)
    {
        base.OnLoaded(e);
        if (Application.Current?.ApplicationLifetime is not IClassicDesktopStyleApplicationLifetime desktop)
            return;
        if (desktop.MainWindow is ThemeDialog s && s != this)
        {
            Icon ??= s.Icon;
        }
    }

    protected override void OnApplyTemplate(TemplateAppliedEventArgs e)
    {
        base.OnApplyTemplate(e);

        var stateObs = this.GetObservable(WindowStateProperty)
            .Do(OnWindowStateChanged)
            .Select(_ => Unit.Default);
        try
        {
            // Create handlers for buttons
            if (e.NameScope.Get<Button>("PART_MaximizeButton") is { } maximize)
            {
                maximize.Click += (_, _) =>
                {
                    if (!CanResize) return;
                    WindowState = WindowState == WindowState.Maximized
                        ? WindowState.Normal
                        : WindowState.Maximized;
                };
            }

            if (e.NameScope.Get<Button>("PART_MinimizeButton") is { } minimize)
                minimize.Click += (_, _) => WindowState = WindowState.Minimized;

            if (e.NameScope.Get<Button>("PART_CloseButton") is { } close)
                close.Click += (_, _) => Close();

            if (e.NameScope.Get<GlassCard>("PART_TitleBarBackground") is { } titleBar)
                titleBar.PointerPressed += OnTitleBarPointerPressed;


            if (e.NameScope.Get<ThemeBackground>("PART_Background") is { } background)
            {
                background.SetAnimationEnabled(BackgroundAnimationEnabled);
                var bgObs = this.GetObservable(BackgroundAnimationEnabledProperty)
                    .Do(enabled => background.SetAnimationEnabled(enabled))
                    .Select(_ => Unit.Default)
                    .Merge(stateObs)
                    .ObserveOn(new AvaloniaSynchronizationContext());

                _subscriptionDisposables = bgObs.Subscribe();
            }
        }
        catch (Exception ex)
        {
            Console.Write(ex.ToString());
        }
    }

    private void OnWindowStateChanged(WindowState state)
    {
        if (state == WindowState.FullScreen)
            CanResize = CanMove = false;
        else
            CanResize = CanMove = true;
    }

    private void OnTitleBarPointerPressed(object? sender, PointerPressedEventArgs e)
    {
        base.OnPointerPressed(e);
        BeginMoveDrag(e);
    }

    protected override void OnUnloaded(RoutedEventArgs e)
    {
        base.OnUnloaded(e);
        _subscriptionDisposables?.Dispose();
    }
}