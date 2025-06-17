import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router_provider.dart';

/// 🧭 [AppRouterConfig] — Wrapper for router provider.
/// ✅ Enables consistent API across Bloc / Riverpod apps.

final class AppRouterConfig {
  ///------------------------
  const AppRouterConfig._();
  //

  /// 🧩 Global router instance from Riverpod
  static final provider = routerProvider;

  /// 💡 Access actual GoRouter object using ref.watch(...)
  static GoRouter use(WidgetRef ref) => ref.watch(routerProvider);

  //
}

/*

final class AppRouterConfig {
  const AppRouterConfig._();

  static final router = goRouter;

  static final delegate = router.routerDelegate;
  static final parser = router.routeInformationParser;
  static final provider = router.routeInformationProvider;
}

 */
