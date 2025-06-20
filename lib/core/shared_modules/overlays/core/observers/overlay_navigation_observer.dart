import 'package:flutter/widgets.dart';
import '../../../../di_container/di_container.dart';
import '../../overlays_dispatcher/_overlay_dispatcher.dart';
import '../../overlays_dispatcher/overlay_dispatcher_provider.dart';

/// 🧭 [OverlayNavigatorObserver] — Clears all overlays on navigation events
/// ✅ Ensures that overlays (banners, snackbars, dialogs) do not persist
/// ✅ Works with GoRouter, Navigator 2.0, or traditional Navigator

final class OverlayNavigatorObserver extends NavigatorObserver {
  ///----------------------------------------------------------

  /// 📦 Reference to the overlay dispatcher (via DI)
  OverlayDispatcher get overlaysDispatcher =>
      globalContainer.read(overlayDispatcherProvider);

  /// 🔁 Called when a new route is pushed onto the navigator
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    overlaysDispatcher.clearAll(); // 🧹 Clear overlays on push
  }

  /// 🔁 Called when a route is popped from the navigator
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    overlaysDispatcher.clearAll(); // 🧹 Clear overlays on pop
  }

  /// 🔁 Called when a route is removed without being completed
  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    overlaysDispatcher.clearAll(); // 🧹 Clear overlays on remove
  }

  /// 🔁 Called when a route is replaced with another
  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    overlaysDispatcher.clearAll(); // 🧹 Clear overlays on replace
  }

  //
}
