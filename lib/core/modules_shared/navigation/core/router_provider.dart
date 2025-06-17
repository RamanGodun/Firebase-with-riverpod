import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../layers_shared/presentation_layer_shared/pages_shared/page_not_found.dart';
import '../utils/overlay_navigation_observer.dart';
import '../utils/routes_redirection_service.dart';
import 'app_routes.dart';
import 'auth_state_stream_provider.dart';
import 'routes_names.dart';

part 'router_provider.g.dart';

/// 🧭🚦 [routerProvider] — GoRouter configuration with global auth-aware redirect
@riverpod
GoRouter router(Ref ref) {
  //
  final authState = ref.watch(authStateStreamProvider);

  ///
  return GoRouter(
    /// 👁️ Observers — Navigation side-effects
    /// - ✅ Auto-clears overlays on push/pop/replace (OverlayDispatcher)
    observers: [OverlayNavigatorObserver()],

    /// ⏳ Initial route (Splash Screen)
    initialLocation: '/${RoutesNames.splash}',

    /// 🐞 Enable GoRouter debug logs (only in debug mode)
    debugLogDiagnostics: true,

    /// 🧭 Redirect logic handled by [RoutesRedirectionService], based on auth state
    redirect: (context, state) {
      return RoutesRedirectionService.map(
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
}

/*

redirect: (context, state) {
  final authState = ref.watch(authStateStreamProvider);

  return AuthRedirectMapper.from(
    isAuthenticated: authState.value != null,
    isVerified: fbAuth.currentUser?.emailVerified ?? false,
    isLoading: authState.isLoading,
    isError: authState.hasError,
    currentPath: state.matchedLocation,
  );
}


 */
