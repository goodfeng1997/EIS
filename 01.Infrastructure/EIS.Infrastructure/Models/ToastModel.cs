using Avalonia.Controls.Notifications;

namespace EIS.Infrastructure.Models;

public readonly record struct ToastModel(
    string Title,
    object Content,
    NotificationType Type = NotificationType.Information,
    TimeSpan? Lifetime = null,
    Action? OnClicked = null,
    string? ActionButtonContent = null,
    Action? ActionButton = null)
{
    public string Title { get; } = Title;
    public object Content { get; } = Content;
    public NotificationType Type { get; } = Type;
    public TimeSpan? Lifetime { get; } = Lifetime;
    public Action? OnClicked { get; } = OnClicked;

    public string? ActionButtonContent { get; } = ActionButtonContent;
    public Action? OnActionButtonClicked { get; } = ActionButton;
}