using Avalonia;
using Avalonia.Controls;
using Avalonia.Controls.Notifications;
using Avalonia.Controls.Primitives;
using Avalonia.Media;
using EIS.Theme.Base;
using EIS.Theme.Content;

namespace EIS.Theme.Controls;

public class InfoBar : ContentControl
{
    public static readonly StyledProperty<NotificationType> SeverityProperty =
        AvaloniaProperty.Register<InfoBar, NotificationType>(nameof(Severity), NotificationType.Information);

    public NotificationType Severity
    {
        get => GetValue(SeverityProperty);
        set
        {
            Icon = value switch
            {
                NotificationType.Information => IconContent.InformationOutline,
                NotificationType.Success => IconContent.Check,
                NotificationType.Warning => IconContent.AlertOutline,
                NotificationType.Error => IconContent.AlertOutline,
                _ => IconContent.InformationOutline
            };
            
            IconForeground = value switch
            {
                NotificationType.Information => NotificationColor.InfoIconForeground,
                NotificationType.Success => NotificationColor.SuccessIconForeground,
                NotificationType.Warning => NotificationColor.WarningIconForeground,
                NotificationType.Error => NotificationColor.ErrorIconForeground,
                _ => NotificationColor.InfoIconForeground
            };
            
            SetValue(SeverityProperty, value);
        }
    }
    
    public static readonly StyledProperty<object?> IconProperty =
        AvaloniaProperty.Register<InfoBar, object?>(nameof(Icon), IconContent.InformationOutline);

    public object? Icon
    {
        get => GetValue(IconProperty);
        private set => SetValue(IconProperty, value);
    }
    
    public static readonly StyledProperty<IBrush?> IconForegroundProperty =
        AvaloniaProperty.Register<InfoBar, IBrush?>(nameof(IconForeground), NotificationColor.InfoIconForeground);
    
    public IBrush? IconForeground
    {
        get => GetValue(IconForegroundProperty);
        private set => SetValue(IconForegroundProperty, value);
    }
    
    public static readonly StyledProperty<bool> IsOpenProperty =
        AvaloniaProperty.Register<InfoBar, bool>(nameof(IsOpen), true);

    public bool IsOpen
    {
        get => GetValue(IsOpenProperty);
        set => SetValue(IsOpenProperty, value);
    }
    
    public static readonly StyledProperty<bool> IsClosableProperty =
        AvaloniaProperty.Register<InfoBar, bool>(nameof(IsClosable), true);

    public bool IsClosable
    {
        get => GetValue(IsClosableProperty);
        set => SetValue(IsClosableProperty, value);
    }
    
       
    public static readonly StyledProperty<bool> IsOpaqueProperty =
        AvaloniaProperty.Register<InfoBar, bool>(nameof(IsOpaque), false);

    public bool IsOpaque
    {
        get => GetValue(IsOpaqueProperty);
        set => SetValue(IsOpaqueProperty, value);
    }
    
    public static readonly StyledProperty<string> TitleProperty =
        AvaloniaProperty.Register<InfoBar, string>(nameof(Title), string.Empty);

    public string Title
    {
        get => GetValue(TitleProperty);
        set => SetValue(TitleProperty, value);
    }

    public static readonly StyledProperty<string> MessageProperty =
        AvaloniaProperty.Register<InfoBar, string>(nameof(Message), string.Empty);

    public string Message
    {
        get => GetValue(MessageProperty);
        set => SetValue(MessageProperty, value);
    }

    protected override void OnApplyTemplate(TemplateAppliedEventArgs e)
    {
        base.OnApplyTemplate(e);

        e.NameScope.Get<Button>("PART_CloseButton").Click += (_, _) => { IsOpen = false;};
    }

    protected override void OnAttachedToVisualTree(VisualTreeAttachmentEventArgs e)
    {
        base.OnAttachedToVisualTree(e);
        if (ContextMenu is null) return;
    }
}