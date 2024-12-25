using Avalonia;
using Avalonia.Controls;
using Avalonia.Controls.Primitives;
using Avalonia.Threading;
using System.Reactive;
using System.Reactive.Linq;
using Avalonia.Interactivity;
using Avalonia.Layout;

namespace EIS.Theme.Controls;

public enum SideMenuTogglePaneButtonPositionOptions
{
    Left,
    Right
}

public class SideMenuControl : SelectingItemsControl
{
    public static readonly StyledProperty<bool> IsMenuExpandedProperty =
        AvaloniaProperty.Register<SideMenuControl, bool>(nameof(IsMenuExpanded), defaultValue: true);

    public bool IsMenuExpanded
    {
        get => GetValue(IsMenuExpandedProperty);
        set => SetValue(IsMenuExpandedProperty, value);
    }
    
    public static readonly StyledProperty<bool> IsRightContentVisibilityProperty =
        AvaloniaProperty.Register<SideMenuControl, bool>(nameof(IsRightContentVisibility), defaultValue: false);

    public bool IsRightContentVisibility
    {
        get => GetValue(IsRightContentVisibilityProperty);
        set => SetValue(IsRightContentVisibilityProperty, value);
    }

    public static readonly StyledProperty<int> OpenPaneLengthProperty =
        AvaloniaProperty.Register<SideMenuControl, int>(nameof(OpenPaneLength), defaultValue: 220);

    public int OpenPaneLength
    {
        get => GetValue(OpenPaneLengthProperty);
        set => SetValue(OpenPaneLengthProperty, value switch
        {
            >= 200 => value,
            _ => throw new ArgumentOutOfRangeException(
                $"OpenPaneLength must be greater than or equal to 200, but was {value}")
        });
    }

    public static readonly StyledProperty<HorizontalAlignment> TogglePaneButtonPositionProperty =
        AvaloniaProperty.Register<SideMenuControl, HorizontalAlignment>(nameof(TogglePaneButtonPosition),
            defaultValue: HorizontalAlignment.Right);

    public SideMenuTogglePaneButtonPositionOptions TogglePaneButtonPosition
    {
        get => GetValue(TogglePaneButtonPositionProperty) switch
        {
            HorizontalAlignment.Right => SideMenuTogglePaneButtonPositionOptions.Right,
            HorizontalAlignment.Left => SideMenuTogglePaneButtonPositionOptions.Left,
            _ => SideMenuTogglePaneButtonPositionOptions.Right
        };
        set => SetValue(TogglePaneButtonPositionProperty, value switch
        {
            SideMenuTogglePaneButtonPositionOptions.Right => HorizontalAlignment.Right,
            SideMenuTogglePaneButtonPositionOptions.Left => HorizontalAlignment.Left,
            _ => HorizontalAlignment.Right
        });
    }

    public static readonly StyledProperty<bool> IsSelectedItemContentMovableProperty =
        AvaloniaProperty.Register<SideMenuControl, bool>(nameof(IsSelectedItemContentMovable), defaultValue: true);

    public bool IsSelectedItemContentMovable
    {
        get => GetValue(IsSelectedItemContentMovableProperty);
        set => SetValue(IsSelectedItemContentMovableProperty, value);
    }

    public static readonly StyledProperty<double> HeaderMinHeightProperty =
        AvaloniaProperty.Register<SideMenuControl, double>(nameof(HeaderMinHeight));

    public double HeaderMinHeight
    {
        get => GetValue(HeaderMinHeightProperty);
        set => SetValue(HeaderMinHeightProperty, value);
    }

    public static readonly StyledProperty<object?> HeaderContentProperty =
        AvaloniaProperty.Register<SideMenuControl, object?>(nameof(HeaderContent));

    public object? HeaderContent
    {
        get => GetValue(HeaderContentProperty);
        set => SetValue(HeaderContentProperty, value);
    }

    public static readonly StyledProperty<object?> FooterContentProperty =
        AvaloniaProperty.Register<SideMenuControl, object?>(nameof(FooterContent));

    public object? FooterContent
    {
        get => GetValue(FooterContentProperty);
        set => SetValue(FooterContentProperty, value);
    }

    private bool IsSpacerVisible => !IsMenuExpanded;

    private IDisposable? _subscriptionDisposable;
    private IDisposable? _contentDisposable;

    public SideMenuControl()
    {
        SelectionMode = SelectionMode.Single | SelectionMode.AlwaysSelected;
    }


    private void MenuExpandedClicked()
    {
        IsMenuExpanded = !IsMenuExpanded;

        if (_sideMenuItems.Any())
            foreach (var item in _sideMenuItems)
                item.IsTopMenuExpanded = IsMenuExpanded;

        else if (Items.FirstOrDefault() is SideMenuItemControl)
            foreach (SideMenuItemControl? item in Items)
                item!.IsTopMenuExpanded = IsMenuExpanded;
    }

    protected override void OnApplyTemplate(TemplateAppliedEventArgs e)
    {
        base.OnApplyTemplate(e);

        if (Items.Any())
        {
            SelectedItem = Items.First();
        }

        e.NameScope.Get<Button>("PART_SidebarToggleButton").Click += (_, _) =>
            MenuExpandedClicked();


        if (e.NameScope.Get<Grid>("PART_Spacer") is { } spacer)
        {
            spacer.IsVisible = IsSpacerVisible;
            var menuObservable = this.GetObservable(IsMenuExpandedProperty)
                .Select(_ => Unit.Default);

            _subscriptionDisposable = menuObservable
                .ObserveOn(new AvaloniaSynchronizationContext())
                .Subscribe(_ => spacer.IsVisible = IsSpacerVisible);
        }

        if (IsRightContentVisibility && e.NameScope.Get<TransitioningContentControl>("PART_TransitioningContentControl") is { } contentControl)
        {
            _contentDisposable = this.GetObservable(SelectedItemProperty)
                .ObserveOn(new AvaloniaSynchronizationContext())
                .Do(obj =>
                {
                    contentControl.Content = obj switch
                    {
                        SideMenuItemControl { PageContent: { } GlobalMenuPageContent } => GlobalMenuPageContent,
                        _ => obj
                    };
                })
                .Subscribe();
        }
    }

    public bool UpdateSelectionFromPointerEvent(Control source)
    {
        return UpdateSelectionFromEventSource(source);
    }

    protected override Control CreateContainerForItemOverride(object? item, int index, object? recycleKey)
    {
        SideMenuItemControl menuItem =
            (ItemTemplate != null && ItemTemplate.Match(item) &&
             ItemTemplate.Build(item) is SideMenuItemControl GlobalMenuItem)
                ? GlobalMenuItem
                : new SideMenuItemControl();
        menuItem.IsContentMovable = IsSelectedItemContentMovable;
        _sideMenuItems.Add(menuItem);
        return menuItem;
    }

    private List<SideMenuItemControl> _sideMenuItems = new();

    protected override bool NeedsContainerOverride(object? item, int index, out object? recycleKey)
    {
        return NeedsContainer<SideMenuItemControl>(item, out recycleKey);
    }

    protected override void OnUnloaded(RoutedEventArgs e)
    {
        base.OnUnloaded(e);
        _contentDisposable?.Dispose();
        _subscriptionDisposable?.Dispose();
    }
}