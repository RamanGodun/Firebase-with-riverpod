import 'package:flutter/widgets.dart';
import '../../di_container/di_container.dart';
import 'overlay_dispatcher/_overlay_dispatcher.dart';
import 'overlay_dispatcher/dispatcher_provider.dart';

// ✅ Goal: Automatically clear active overlays when navigating between screens
/// 🧩 [OverlayNavigatorObserver] — Observes navigation events to clear overlays
/// 📌 Use in GoRouter via `navigatorBuilder`, or wrap `MaterialApp.router`
///----------------------------------------------------------------

final class OverlayNavigatorObserver extends NavigatorObserver {
  //
  OverlayDispatcher get dispatcher =>
      globalContainer.read(overlayDispatcherProvider);

  ///
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    dispatcher.clearAll();
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    dispatcher.clearAll();
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    dispatcher.clearAll();
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    dispatcher.clearAll();
  }
}
