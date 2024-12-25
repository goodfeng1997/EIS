using Avalonia;
using Avalonia.Controls;
using Avalonia.Controls.Presenters;
using Avalonia.Rendering.Composition;
using EIS.Theme.Base;

namespace EIS.Theme.Extensions
{
    public static class StackPanelExtension
    {
        public static readonly AttachedProperty<bool> AnimatedScrollProperty =
            AvaloniaProperty.RegisterAttached<StackPanel, bool>("AnimatedScroll", typeof(StackPanel),
                defaultValue: false);

        static StackPanelExtension()
        {
            AnimatedScrollProperty.Changed.AddClassHandler<StackPanel>(HandleAnimatedScrollChanged);
        }

        private static void HandleAnimatedScrollChanged(StackPanel interactElem, AvaloniaPropertyChangedEventArgs args)
        {
            if (GetAnimatedScroll(interactElem))
                interactElem.AttachedToVisualTree += (sender, args) =>
                    Scrollable.MakeScrollable(ElementComposition.GetElementVisual(interactElem));
        }

        public static bool GetAnimatedScroll(StackPanel wrap)
        {
            return wrap.GetValue(AnimatedScrollProperty);
        }

        public static void SetAnimatedScroll(StackPanel wrap, bool value)
        {
            wrap.SetValue(AnimatedScrollProperty, value);
        }
    }

    public static class ItemsPresenterExtension
    {
        public static readonly AttachedProperty<bool> AnimatedScrollProperty =
            AvaloniaProperty.RegisterAttached<ItemsPresenter, bool>("AnimatedScroll", typeof(ItemsPresenter),
                defaultValue: false);

        static ItemsPresenterExtension()
        {
            AnimatedScrollProperty.Changed.AddClassHandler<ItemsPresenter>(HandleAnimatedScrollChanged);
        }

        private static void HandleAnimatedScrollChanged(ItemsPresenter interactElem,
            AvaloniaPropertyChangedEventArgs args)
        {
            if (GetAnimatedScroll(interactElem))
                interactElem.AttachedToVisualTree += (sender, _) =>
                    Scrollable.MakeScrollable(ElementComposition.GetElementVisual(interactElem));
        }

        public static bool GetAnimatedScroll(ItemsPresenter wrap)
        {
            return wrap.GetValue(AnimatedScrollProperty);
        }

        public static void SetAnimatedScroll(ItemsPresenter wrap, bool value)
        {
            wrap.SetValue(AnimatedScrollProperty, value);
        }
    }
    
    public static class ItemsControlExtension
    {
        public static readonly AttachedProperty<bool> AnimatedScrollProperty =
            AvaloniaProperty.RegisterAttached<ItemsControl, bool>("AnimatedScroll", typeof(ItemsControl),
                defaultValue: false);

        static ItemsControlExtension()
        {
            AnimatedScrollProperty.Changed.AddClassHandler<ItemsControl>(HandleAnimatedScrollChanged);
        }

        private static void HandleAnimatedScrollChanged(ItemsControl interactElem,
            AvaloniaPropertyChangedEventArgs args)
        {
            if (GetAnimatedScroll(interactElem))
                interactElem.AttachedToVisualTree += (sender, _) =>
                    Scrollable.MakeScrollable(ElementComposition.GetElementVisual(interactElem));
        }

        public static bool GetAnimatedScroll(ItemsControl wrap)
        {
            return wrap.GetValue(AnimatedScrollProperty);
        }

        public static void SetAnimatedScroll(ItemsControl wrap, bool value)
        {
            wrap.SetValue(AnimatedScrollProperty, value);
        }
    }
}