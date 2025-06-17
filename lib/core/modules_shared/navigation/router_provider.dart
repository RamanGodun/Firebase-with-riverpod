import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../layers_shared/presentation_layer_shared/pages_shared/page_not_found.dart';
import 'utils/routes_map.dart';
import 'utils/routes_redirection_service.dart';
import 'utils/auth_state_stream_provider.dart';

part 'router_provider.g.dart';

/// 🧭 [routerProvider] — GoRouter configuration with global auth-aware redirect
@riverpod
GoRouter router(Ref ref) {
  //
  final authState = ref.watch(authStateStreamProvider);

  ///
  return GoRouter(
    initialLocation: '/splash',

    /// 🔐 Redirect logic handled by [AuthRedirectMapper], based on auth state
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
