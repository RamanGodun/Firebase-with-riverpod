part of 'go_router_provider.dart';

/// 🧭🚦 Returns fully constructed [GoRouter] instance
//
GoRouter buildGoRouter(Ref ref) {
  ///--------------------------

  return GoRouter(
    //
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

    /// 🔁 Triggers route evaluation when `authState` changes
    // refreshListenable: ref.watch(authStateRefreshListenableProvider),

    /// 🧭 Global redirect handler — routes user depending on auth state
    redirect: (context, state) {
      final authState = ref.watch(authStateStreamProvider);
      // final authState = ref.read(authStateStreamProvider); // ? when using refreshListenable
      return RoutesRedirectionService.from(context, state, authState);
    },
  );
}
