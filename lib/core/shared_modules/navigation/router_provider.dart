import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared_presentation/pages/page_not_found.dart';
import 'routes_map.dart';
import 'utils/auth_redirect.dart';

part 'router_provider.g.dart';

/// 🧭 [routerProvider] — GoRouter configuration with global auth-aware redirect
@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: '/splash',

    /// 🔐 Redirect logic handled by [AuthRedirectMapper], based on auth state
    redirect: (context, state) {
      return AuthRedirectMapper.map(ref: ref, state: state);
    },

    /// 📌 Route definitions
    routes: AppRoutes.all,

    /// ❌ Wildcard handler for unmatched routes
    errorBuilder:
        (context, state) => PageNotFound(errorMessage: state.error.toString()),
  );

  //
}
