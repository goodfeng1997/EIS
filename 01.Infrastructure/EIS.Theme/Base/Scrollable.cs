using Avalonia.Rendering.Composition.Animations;
using Avalonia.Rendering.Composition;

namespace EIS.Theme.Base
{
    public static class Scrollable
    {
        public static void MakeScrollable(CompositionVisual? compositionVisual)
        {
            if (compositionVisual == null)
                return;

            Compositor compositor = compositionVisual.Compositor;

            var animationGroup = compositor.CreateAnimationGroup();
            Vector3KeyFrameAnimation offsetAnimation = compositor.CreateVector3KeyFrameAnimation();
            offsetAnimation.Target = "Offset";

            offsetAnimation.InsertExpressionKeyFrame(1.0f, "this.FinalValue");
            offsetAnimation.Duration = TimeSpan.FromMilliseconds(250);

            ImplicitAnimationCollection implicitAnimationCollection = compositor.CreateImplicitAnimationCollection();
            animationGroup.Add(offsetAnimation);
            implicitAnimationCollection["Offset"] = animationGroup;
            compositionVisual.ImplicitAnimations = implicitAnimationCollection;
        }
    }
}
