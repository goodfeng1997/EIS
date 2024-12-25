using Avalonia;
using Avalonia.Controls;
using Avalonia.Markup.Xaml;

namespace EIS.Theme.Controls.UserControls;

public partial class CircleProgressBar : ContentControl
{
    public CircleProgressBar()
    {
        InitializeComponent();
    }

    private void InitializeComponent()
    {
        AvaloniaXamlLoader.Load(this);
    }

    private double _value = 50;

    public double Value
    {
        get => _value;
        set
        {
            _value = (int)(value * 3.6);
            SetValue(ValueProperty, _value);
        }
    }

    /// <summary>
    /// Defines the <see cref="Value"/> property.
    /// </summary>
    public static readonly StyledProperty<double> ValueProperty =
        AvaloniaProperty.Register<CircleProgressBar, double>(nameof(Value), defaultValue: 50,
            coerce: (_, d) => d * 3.6);


    public new static readonly StyledProperty<int> HeightProperty =
        AvaloniaProperty.Register<CircleProgressBar, int>(nameof(Height), defaultValue: 150);

    public new int Height
    {
        get => GetValue(HeightProperty);
        set => SetValue(HeightProperty, value);
    }

    public new static readonly StyledProperty<int> WidthProperty =
        AvaloniaProperty.Register<CircleProgressBar, int>(nameof(Width), defaultValue: 150);

    public new int Width
    {
        get => GetValue(WidthProperty);
        set => SetValue(WidthProperty, value);
    }

    public static readonly StyledProperty<int> StrokeWidthProperty =
        AvaloniaProperty.Register<CircleProgressBar, int>(nameof(StrokeWidth), defaultValue: 10);

    public int StrokeWidth
    {
        get => GetValue(StrokeWidthProperty);
        set => SetValue(StrokeWidthProperty, value);
    }

    public static readonly StyledProperty<bool> IsIndeterminateProperty =
        AvaloniaProperty.Register<CircleProgressBar, bool>(nameof(IsIndeterminate), false);

    public bool IsIndeterminate
    {
        get => GetValue(IsIndeterminateProperty);
        set => SetValue(IsIndeterminateProperty, value);
    }
}