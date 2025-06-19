import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../layers_shared/domain_layer_shared/providers_shared/auth_state_provider.dart';
import '../../../layers_shared/domain_layer_shared/providers_shared/auth_state_refresher_provider.dart';
import '../../../layers_shared/presentation_layer_shared/pages_shared/page_not_found.dart';
import '../utils/overlay_navigation_observer.dart';
import '../utils/routes_redirection_service.dart';
import '../app_routes/app_routes.dart';

/// 🧭🚦 [goRouter] — GoRouter configuration with global auth-aware redirect

final goRouter = Provider<GoRouter>((ref) {
  ///------------------------------------

  /// 👤 Firebase user authentication state
  final authState = ref.watch(authStateStreamProvider);
  // 🔁 Notifier that triggers GoRouter refresh when auth state updates
  final refresher = ref.watch(authStateRefreshStreamProvider);

  ///
  return GoRouter(
    ///
    /// 👁️ Observers — navigation side-effects (e.g., dismissing overlays)
    observers: [OverlayNavigatorObserver()],

    /// 🐞 Enable verbose logging for GoRouter (only active in debug mode)
    debugLogDiagnostics: true,

    ///

    /// ⏳ Initial route shown on app launch (Splash Screen)
    initialLocation: RoutesPaths.splash,

    /// 🗺️ Route definitions used across the app
    routes: AppRoutes.all,

    /// ❌ Fallback UI for unknown/unmatched routes
    errorBuilder:
        (context, state) => PageNotFound(errorMessage: state.error.toString()),

    ///

    /// 🔁 Triggers route evaluation when `authState` changes
    refreshListenable: refresher,

    /// 🧭 Global redirect handler — routes user depending on auth state
    redirect: (context, state) {
      return RoutesRedirectionService.from(context, state, authState);
    },

    //
  );

  //
});
