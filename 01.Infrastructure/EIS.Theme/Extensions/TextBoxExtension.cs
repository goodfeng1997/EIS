using Avalonia;
using Avalonia.Controls;
using Avalonia.Media;
using Avalonia.Threading;

namespace EIS.Theme.Extensions;

public static class TextBoxExtension
{
    public static readonly AttachedProperty<string> PrefixProperty =
        AvaloniaProperty.RegisterAttached<TextBox, string>("Prefix", typeof(TextBox), defaultValue: "");

    public static string GetPrefix(TextBox textBox)
    {
        return textBox.GetValue(PrefixProperty);
    }

    public static void SetPrefix(TextBox textBox, string value)
    {
        textBox.SetValue(PrefixProperty, value);
    }

    public static readonly AttachedProperty<bool> AddDeleteButtonProperty =
        AvaloniaProperty.RegisterAttached<TextBox, bool>("AddDeleteButton", typeof(TextBox), defaultValue: false);

    public static bool GetAddDeleteButton(TextBox textBox)
    {
        return textBox.GetValue(AddDeleteButtonProperty);
    }

    public static void SetAddDeleteButton(TextBox textBox, bool value)
    {
        textBox.SetValue(AddDeleteButtonProperty, value);
    }

    public static void Error(this TextBox textbox, string message)
    {
        Dispatcher.UIThread.Invoke(() =>
        {
            textbox.BorderBrush = Brushes.IndianRed;

            textbox.ContextFlyout = new Flyout()
            {
                Placement = PlacementMode.BottomEdgeAlignedLeft,
                Content = new TextBlock() { Text = message, FontWeight = FontWeight.Thin, Foreground = Brushes.IndianRed }
            };
            textbox.ContextFlyout.ShowAt(textbox);
            //textbox.Vibrate(TimeSpan.FromMilliseconds(400));
        });
    }
}