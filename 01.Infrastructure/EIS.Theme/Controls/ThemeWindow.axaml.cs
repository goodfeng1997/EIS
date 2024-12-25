using Avalonia;
using Avalonia.Controls;
using Avalonia.Controls.Primitives;
using Avalonia.Input;
using Avalonia.Media;
using Avalonia.Threading;
using System.Reactive;
using System.Reactive.Linq;
using Avalonia.Collections;
using Avalonia.Controls.ApplicationLifetimes;
using Avalonia.Interactivity;
using EIS.Theme.Content;

namespace EIS.Theme.Controls;

public class ThemeWindow : Window
{
    protected override Type StyleKeyOverride => typeof(ThemeWindow);

    public static readonly StyledProperty<double> TitleFontSizeProperty =
        AvaloniaProperty.Register<ThemeWindow, double>(nameof(TitleFontSize), defaultValue: 13);

    public double TitleFontSize
    {
        get => GetValue(TitleFontSizeProperty);
        set => SetValue(TitleFontSizeProperty, value);
    }

    public static readonly StyledProperty<FontWeight> TitleFontWeightProperty =
        AvaloniaProperty.Register<ThemeWindow, FontWeight>(nameof(TitleFontWeight),
            defaultValue: FontWeight.Bold);

    public FontWeight TitleFontWeight
    {
        get => GetValue(TitleFontWeightProperty);
        set => SetValue(TitleFontWeightProperty, value);
    }

    public static readonly StyledProperty<Control?> LogoContentProperty =
        AvaloniaProperty.Register<ThemeWindow, Control?>(nameof(LogoContent));

    public Control? LogoContent
    {
        get => GetValue(LogoContentProperty);
        set => SetValue(LogoContentProperty, value);
    }

    public static readonly StyledProperty<bool> ShowBottomBorderProperty =
        AvaloniaProperty.Register<ThemeWindow, bool>(nameof(ShowBottomBorder), defaultValue: true);

    public bool ShowBottomBorder
    {
        get => GetValue(ShowBottomBorderProperty);
        set => SetValue(ShowBottomBorderProperty, value);
    }

    public static readonly StyledProperty<bool> IsTitleBarVisibleProperty =
        AvaloniaProperty.Register<ThemeWindow, bool>(nameof(IsTitleBarVisible), defaultValue: true);

    public bool IsTitleBarVisible
    {
        get => GetValue(IsTitleBarVisibleProperty);
        set => SetValue(IsTitleBarVisibleProperty, value);
    }

    public static readonly StyledProperty<bool> IsMenuVisibleProperty =
        AvaloniaProperty.Register<ThemeWindow, bool>(nameof(IsMenuVisible), defaultValue: false);

    public bool IsMenuVisible
    {
        get => GetValue(IsMenuVisibleProperty);
        set => SetValue(IsMenuVisibleProperty, value);
    }

    public static readonly StyledProperty<AvaloniaList<MenuItem>?> MenuItemsProperty =
        AvaloniaProperty.Register<ThemeWindow, AvaloniaList<MenuItem>?>(nameof(MenuItems));

    public AvaloniaList<MenuItem>? MenuItems
    {
        get => GetValue(MenuItemsProperty);
        set => SetValue(MenuItemsProperty, value);
    }

    public static readonly StyledProperty<bool> BackgroundAnimationEnabledProperty =
        AvaloniaProperty.Register<ThemeWindow, bool>(nameof(BackgroundAnimationEnabled), defaultValue: false);

    public bool BackgroundAnimationEnabled
    {
        get => GetValue(BackgroundAnimationEnabledProperty);
        set => SetValue(BackgroundAnimationEnabledProperty, value);
    }

    public static readonly StyledProperty<bool> CanMinimizeProperty =
        AvaloniaProperty.Register<ThemeWindow, bool>(nameof(CanMinimize), defaultValue: true);

    public bool CanMinimize
    {
        get => GetValue(CanMinimizeProperty);
        set => SetValue(CanMinimizeProperty, value);
    }

    public static readonly StyledProperty<bool> CanMoveProperty =
        AvaloniaProperty.Register<ThemeWindow, bool>(nameof(CanMove), defaultValue: true);

    public bool CanMove
    {
        get => GetValue(CanMoveProperty);
        set => SetValue(CanMoveProperty, value);
    }

    public ThemeWindow()
    {
        MenuItems = new AvaloniaList<MenuItem>();
    }

    private IDisposable? _subscriptionDisposables;

    protected override void OnLoaded(RoutedEventArgs e)
    {
        base.OnLoaded(e);
        if (Application.Current?.ApplicationLifetime is not IClassicDesktopStyleApplicationLifetime desktop)
            return;
        if (desktop.MainWindow is ThemeWindow s && s != this)
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
        catch(Exception ex)
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
