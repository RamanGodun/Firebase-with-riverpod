import 'package:flutter/material.dart';

import '../animation_engines/__animation_engine.dart';

/// 🎞️ [AnimatedOverlayShell] — Universal animation shell for overlays
/// - Wraps child with Slide (optional) + Fade + Scale transitions
/// - Used in: banners, dialogs, snackbars (Android/iOS)
/// - Accepts [AnimationEngine] with configured transitions
/// ───────────────────────────────────────────────────────────────
final class AnimatedOverlayShell extends StatelessWidget {
  final AnimationEngine engine;
  final Widget child;

  const AnimatedOverlayShell({
    super.key,
    required this.engine,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Widget animated = FadeTransition(
      opacity: engine.opacity,
      child: ScaleTransition(scale: engine.scale, child: child),
    );

    // Optional Slide wrapper
    if (engine.slide != null) {
      animated = SlideTransition(position: engine.slide!, child: animated);
    }

    return animated;
  }
}
