import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../app_routes/app_routes.dart';

/// 🧭🚦 [RoutesRedirectionService] — centralized redirect logic for GoRouter
/// 🔐 Dynamically handles redirection based on Firebase auth state:
///   - 🚪 `/signin` if unauthenticated
///   - 🧪 `/verifyEmail` if email is not verified
///   - 🧯 `/firebaseError` if an auth error occurs
///   - ⏳ `/splash` while loading
///   - ✅ `/home` if fully authenticated and verified

abstract final class RoutesRedirectionService {
  //----------------------------------------------
  RoutesRedirectionService._();
  //

  /// 🗝️ Publicly accessible routes (no authentication required)
  static const Set<String> _publicRoutes = {
    RoutesPaths.signIn,
    RoutesPaths.signUp,
    RoutesPaths.resetPassword,
  };

  //

  /// 🔁 Maps current router state + auth state to a redirect route (if needed)
  static String? from({
    required GoRouterState goRouterState,
    required AsyncValue<User?> authState,
  }) {
    // 🔄 CurrentPath inside method
    final currentPath = goRouterState.matchedLocation;

    debugPrint('[🔁 Redirect] from() called → currentPath: $currentPath');

    // 🔄 Derive directly from state
    final isLoading = authState is AsyncLoading<User?>;
    final isAuthError = authState is AsyncError<User?>;
    final user = authState.valueOrNull;
    final isAuthenticated = user != null;
    final isEmailVerified = user?.emailVerified ?? false;
    debugPrint('[🔁 Redirect] user: $user, isVerified: $isEmailVerified');

    final isOnPublicPages = _publicRoutes.contains(currentPath);
    final isOnVerifyPage = currentPath == RoutesPaths.verifyEmail;
    final isOnSplashPage = currentPath == RoutesPaths.splash;

    //
    // ⏳ Redirect to splash while loading
    if (isLoading) return RoutesPaths.splash;

    // 💥 Redirect to error page if auth error
    if (isAuthError) return RoutesPaths.signIn;

    // 🚪 Redirect to SignIn page if unauthenticated and not on public page
    if (!isAuthenticated) return isOnPublicPages ? null : RoutesPaths.signIn;

    // 🧪 Redirect to /verifyEmail if not verified
    if (!isEmailVerified)
      return isOnVerifyPage ? null : RoutesPaths.verifyEmail;

    // ✅ Redirect to /home if already authenticated and on splash/public/verify
    // if ((isOnPublicPages || isOnSplashPage || isOnVerifyPage) &&
    //     isEmailVerified)
    //   return RoutesPaths.home;
    if ((isOnPublicPages || isOnSplashPage || isOnVerifyPage) &&
        isEmailVerified) {
      debugPrint('[🔁 Redirect] ✅ Redirecting to home — email verified');
      return RoutesPaths.home;
    }

    // ➖ No redirect
    return null;
  }

  //
}

/*
? for debugging:

    if (kDebugMode) {
        debugPrint(
          '[🔁 Redirect] $currentPath → $target (authStatus: unknown)',
        );
      }
 */
