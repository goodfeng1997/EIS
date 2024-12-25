using EIS.Theme.Controls;

namespace EIS.Theme.Base.Toast;

internal static class ToastPool
{
    private static readonly Stack<ThemeToast> Pool = new();

    internal static ThemeToast Get()
    {
        return Pool.Count >= 1 ? Pool.Pop() : new ThemeToast();
    }

    internal static void Return(ThemeToast toast) => Pool.Push(toast);

    internal static void Return(IEnumerable<ThemeToast>? toasts)
    {
        if (toasts is null) return;
        foreach (var toast in toasts)
            Pool.Push(toast);
    }
}