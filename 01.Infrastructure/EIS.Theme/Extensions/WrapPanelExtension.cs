using Avalonia.Controls;
using Avalonia;
using Avalonia.Rendering.Composition;
using EIS.Theme.Base;

namespace EIS.Theme.Extensions
{
    public static class WrapPanelExtension
    {
        public static readonly AttachedProperty<bool> AnimatedScrollProperty =
            AvaloniaProperty.RegisterAttached<WrapPanel, bool>("AnimatedScroll", typeof(WrapPanel), defaultValue: false);

        static WrapPanelExtension()
        {
            AnimatedScrollProperty.Changed.AddClassHandler<WrapPanel>(HandleAnimatedScrollChanged);
        }

        private static void HandleAnimatedScrollChanged(WrapPanel interactElem, AvaloniaPropertyChangedEventArgs args)
        {
            if (GetAnimatedScroll(interactElem))
                interactElem.AttachedToVisualTree += (sender, _) => Scrollable.MakeScrollable(ElementComposition.GetElementVisual(interactElem));
        }

        public static bool GetAnimatedScroll(WrapPanel wrap)
        {
            return wrap.GetValue(AnimatedScrollProperty);
        }

        public static void SetAnimatedScroll(WrapPanel wrap, bool value)
        {
            wrap.SetValue(AnimatedScrollProperty, value);
        }

    }
}
