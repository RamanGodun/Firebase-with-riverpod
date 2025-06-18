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
  ///---------------------------------------------

  final authState = ref.watch(authStateStreamProvider);
  final refresher = ref.watch(authStateRefreshStreamProvider);

  ///
  return GoRouter(
    /// 👁️ Observers — Navigation side-effects
    /// - ✅ Auto-clears overlays on push/pop/replace (OverlayDispatcher)
    observers: [OverlayNavigatorObserver()],

    /// ⏳ Initial route (Splash Screen)
    initialLocation: RoutesPaths.splash,

    /// 🐞 Enable GoRouter debug logs (only in debug mode)
    debugLogDiagnostics: true,

    ///
    refreshListenable: refresher,

    /// 🧭 Redirect logic handled by [RoutesRedirectionService], based on auth state
    redirect: (context, state) {
      return RoutesRedirectionService.from(
        goRouterState: state,
        authState: authState,
      );
    },

    /// 📌 Route definitions
    routes: AppRoutes.all,

    /// ❌ Wildcard handler for unmatched routes
    errorBuilder:
        (context, state) => PageNotFound(errorMessage: state.error.toString()),
  );

  //
});
