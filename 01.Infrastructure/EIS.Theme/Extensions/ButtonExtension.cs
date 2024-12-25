using Avalonia;
using Avalonia.Controls;

namespace EIS.Theme.Extensions
{
    public static class ButtonExtension
    {
        public static readonly AttachedProperty<bool> ShowProgressProperty =
            AvaloniaProperty.RegisterAttached<Button, bool>("ShowProgress", typeof(Button), defaultValue: false);

        public static bool GetShowProgress(Button textBox)
        {
            return textBox.GetValue(ShowProgressProperty);
        }

        public static void SetShowProgress(Button textBox, bool value)
        {
            textBox.SetValue(ShowProgressProperty, value);
        }

        public static void ShowProgress(this Button textBox)
        {
            textBox.SetValue(ShowProgressProperty, true);
        }

        public static void HideProgress(this Button textBox)
        {
            textBox.SetValue(ShowProgressProperty, false);
        }
    }
}
