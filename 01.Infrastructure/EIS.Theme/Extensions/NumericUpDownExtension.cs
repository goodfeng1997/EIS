using Avalonia;
using Avalonia.Controls;

namespace EIS.Theme.Extensions
{
    public class NumericUpDownExtension
    {
        public static readonly AttachedProperty<string> UnitProperty =
            AvaloniaProperty.RegisterAttached<NumericUpDown, string>("Unit", typeof(NumericUpDown), defaultValue: "");

        public static string GetUnit(NumericUpDown textBox)
        {
            return textBox.GetValue(UnitProperty);
        }

        public static void SetUnit(NumericUpDown textBox, string value)
        {
            textBox.SetValue(UnitProperty, value);
        }
    }
}