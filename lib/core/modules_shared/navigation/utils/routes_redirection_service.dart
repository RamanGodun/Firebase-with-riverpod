import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app_configs/firebase/firebase_constants.dart';

/// 🧭 [RoutesRedirectionService] — centralized redirect logic for GoRouter
/// 🔐 Dynamically handles redirection based on Firebase auth state:
///   - 🚪 `/signin` if unauthenticated
///   - 🧪 `/verifyEmail` if email is not verified
///   - 🧯 `/firebaseError` if an auth error occurs
///   - ⏳ `/splash` while loading
///   - ✅ `/home` if fully authenticated and verified

abstract final class RoutesRedirectionService {
  //----------------------------------------------
  RoutesRedirectionService._();

  ///

  /// 🗝️ Publicly accessible routes (no authentication required)
  static const Set<String> _publicRoutes = {
    '/signin',
    '/signup',
    '/resetPassword',
  };

  ///

  /// 🔁📤 Maps current router state to an optional redirect path, returns:
  /// a new path as [String] if redirection is needed, or null otherwise
  static String? map({
    required GoRouterState goRouterState, // current GoRouter state
    required AsyncValue<User?> authState,
  }) {
    ///
    final isAuthenticated = authState.valueOrNull != null;
    final isVerified = fbAuth.currentUser?.emailVerified ?? false;

    final isOnPublicPages = _publicRoutes.contains(
      goRouterState.matchedLocation,
    );
    final isOnVerifyPage = goRouterState.matchedLocation == '/verifyEmail';
    final isOnSplashPage = goRouterState.matchedLocation == '/splash';

    //
    // ⏳ Redirect to splash while loading
    if (authState is AsyncLoading<User?>) return '/splash';

    // 💥 Redirect to error page if auth error
    if (authState is AsyncError<User?>) return '/firebaseError';

    // 🚪 Redirect to SignIn page if unauthenticated and not on public page
    if (!isAuthenticated) return isOnPublicPages ? null : '/signin';

    // 🧪 Redirect to /verifyEmail if not verified
    if (!isVerified) return isOnVerifyPage ? null : '/verifyEmail';

    // ✅ Redirect to /home if already authenticated and on splash/public/verify
    if (isOnPublicPages || isOnSplashPage || isOnVerifyPage) return '/home';

    // ➖ No redirect
    return null;
  }

  //
}
