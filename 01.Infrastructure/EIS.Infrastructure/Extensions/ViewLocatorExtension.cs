using Avalonia;
using Avalonia.Controls;
using Avalonia.Controls.Templates;

namespace EIS.Infrastructure.Extensions;

public static class ViewLocatorExtension
{
    private static IDataTemplate? _locator;
    public static Control TryBuild(object? data)
    {
        if (data is string s) return new TextBlock() { Text = s };
        _locator ??= Application.Current?.DataTemplates.FirstOrDefault();
        return _locator?.Build(data) ?? new TextBlock() { Text = $"Unable to find suitable view for {data?.GetType().Name}" };
    }
}