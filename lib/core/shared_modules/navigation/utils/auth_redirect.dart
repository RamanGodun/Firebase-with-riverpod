import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app_config/firebase/firebase_constants.dart';

/// 🧭 [AuthRedirectMapper] — centralized redirect logic for GoRouter
/// 🔐 Dynamically handles redirection based on Firebase auth state:
///   - 🚪 `/signin` if unauthenticated
///   - 🧪 `/verifyEmail` if email is not verified
///   - 🧯 `/firebaseError` if an auth error occurs
///   - ⏳ `/splash` while loading
///   - ✅ `/home` if fully authenticated and verified
//------------------------------------------------------------------------------
abstract final class AuthRedirectMapper {
  AuthRedirectMapper._();

  /// 🗝️ Publicly accessible routes (no authentication required)
  static const Set<String> _publicRoutes = {
    '/signin',
    '/signup',
    '/resetPassword',
  };

  /// 🔁 Maps current router state to an optional redirect path
  /// 📥 Parameters:
  /// - [ref] — Riverpod reference to access providers
  /// - [state] — current GoRouter state
  /// 📤 Returns:
  /// - A new path as [String] if redirection is needed, or null otherwise
  static String? map({
    required GoRouterState state,
    required AsyncValue<User?> authState,
  }) {
    //
    // ⏳ Redirect to splash while loading
    if (authState is AsyncLoading<User?>) return '/splash';

    // 💥 Redirect to error page if auth error
    if (authState is AsyncError<User?>) return '/firebaseError';

    final isAuthenticated = authState.valueOrNull != null;
    final isVerified = fbAuth.currentUser?.emailVerified ?? false;

    final isOnPublic = _publicRoutes.contains(state.matchedLocation);
    final isOnVerify = state.matchedLocation == '/verifyEmail';
    final isOnSplash = state.matchedLocation == '/splash';

    // 🚪 Redirect to /signin if unauthenticated and not on public page
    if (!isAuthenticated) return isOnPublic ? null : '/signin';

    // 🧪 Redirect to /verifyEmail if not verified
    if (!isVerified) return isOnVerify ? null : '/verifyEmail';

    // ✅ Redirect to /home if already authenticated and on splash/public/verify
    if (isOnPublic || isOnSplash || isOnVerify) return '/home';

    // ➖ No redirect
    return null;
  }

  //
}
