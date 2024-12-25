using Avalonia;
using Avalonia.Controls;
using Avalonia.Markup.Xaml;

namespace EIS.Theme.Controls.UserControls;

public partial class WaveProgress : UserControl
{
    public WaveProgress()
    {
        InitializeComponent();
        var theme = GlobalTheme.GetInstance();
        theme.OnBaseThemeChanged += _ =>
        {
            Value++;
            Value--;
        };
        theme.OnColorThemeChanged += _ =>
        {
            Value++;
            Value--;
        };
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
            if (value is < 0 or > 100)
                return;

            SetValue(ValueProperty,value);
        }
    }

    public static readonly StyledProperty<double> ValueProperty =
        AvaloniaProperty.Register<CircleProgressBar, double>(nameof(Value), defaultValue: 50);
    
   

    public static readonly StyledProperty<bool> IsTextVisibleProperty = AvaloniaProperty.Register<WaveProgress, bool>(nameof(IsTextVisible), defaultValue: true);

    public bool IsTextVisible
    {
        get => GetValue(IsTextVisibleProperty);
        set => SetValue(IsTextVisibleProperty, value);
    }
}