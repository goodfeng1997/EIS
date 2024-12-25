using Avalonia.Media;
using EIS.Infrastructure.Enums;

namespace EIS.Infrastructure.Models;

public record ColorThemeModel(string DisplayName, Color Primary, Color Accent)
{
    public IBrush PrimaryBrush => new SolidColorBrush(Primary);

    public IBrush AccentBrush => new SolidColorBrush(Accent);

    public override int GetHashCode()
    {
        unchecked
        {
            var hash = 17;
            hash *= 31 + Primary.GetHashCode();
            hash *= 31 + Accent.GetHashCode();
            hash *= 31 + DisplayName.GetHashCode();
            return hash;
        }
    }

    public override string ToString()
    {
        return DisplayName;
    }
}

public record DefaultColorThemeModel(ColorThemeEnum ThemeColor, Color Primary, Color Accent)
    : ColorThemeModel(ThemeColor.ToString(), Primary, Accent);