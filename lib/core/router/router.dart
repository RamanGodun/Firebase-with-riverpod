import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/change_password/change_password_page.dart';
import '../../features/profile_page/profile_page.dart';
import '../../presentation/pages/firebase_error_page.dart';
import '../../presentation/pages/page_not_found.dart';
import '../../features/reset_password/reset_password_page.dart';
import '../../features/sign_in/signin_page.dart';
import '../../features/sign_up/signup_page.dart';
import '../../features/user_validation/reauthenticate_page.dart';
import '../../features/user_validation/verify_email_page.dart';
import '../../presentation/widgets/mini_widgets.dart';
import '../../data/repositories/auth/auth_repository_provider.dart';
import '../../data/sources/remote/firebase_constants.dart';
import '../../presentation/pages/_home_page.dart';
import 'routes_names.dart';

part 'router.g.dart';

/// 🧭 [router] — GoRouter provider with dynamic auth-aware redirects
/// Listens to Firebase auth state and redirects:
///   • `/signin` if unauthenticated
///   • `/verifyEmail` if email is not verified
///   • `/firebaseError` on auth stream error
///   • `/splash` while loading
///   • Otherwise → `/home` or matched route

@riverpod
GoRouter router(Ref ref) {
  final authState = ref.watch(authStateStreamProvider);

  return GoRouter(
    initialLocation: '/splash',

    /// 🔁 Auth-aware redirection logic
    redirect: (context, state) {
      if (authState is AsyncLoading<User?>) return '/splash';
      if (authState is AsyncError<User?>) return '/firebaseError';

      final authenticated = authState.valueOrNull != null;

      final isOnAuthScreen =
          (state.matchedLocation == '/signin') ||
          (state.matchedLocation == '/signup') ||
          (state.matchedLocation == '/resetPassword');

      if (!authenticated) {
        return isOnAuthScreen ? null : '/signin';
      }

      if (!fbAuth.currentUser!.emailVerified) {
        return '/verifyEmail';
      }

      final isOnVerifyEmail = state.matchedLocation == '/verifyEmail';
      final isOnSplash = state.matchedLocation == '/splash';

      return (isOnAuthScreen || isOnVerifyEmail || isOnSplash) ? '/home' : null;
    },

    /// 🗺️ App Routes
    routes: [
      GoRoute(
        path: '/splash',
        name: RoutesNames.splash,
        builder: (context, state) => const MiniWidgets(MWType.loading),
      ),

      /// *Home Screen & Nested Routes
      GoRoute(
        path: '/home',
        name: RoutesNames.home,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: 'changePassword',
            name: RoutesNames.changePassword,
            builder: (context, state) => const ChangePasswordPage(),
          ),
          GoRoute(
            path: 'profile',
            name: RoutesNames.profilePage,
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),

      GoRoute(
        path: '/firebaseError',
        name: RoutesNames.firebaseError,
        builder: (context, state) => const FirebaseErrorPage(),
      ),

      GoRoute(
        path: '/signin',
        name: RoutesNames.signin,
        builder: (context, state) => const SignInPage(),
      ),

      GoRoute(
        path: '/signup',
        name: RoutesNames.signup,
        builder: (context, state) => const SignupPage(),
      ),

      GoRoute(
        path: '/resetPassword',
        name: RoutesNames.resetPassword,
        builder: (context, state) => const ResetPasswordPage(),
      ),

      GoRoute(
        path: '/verifyEmail',
        name: RoutesNames.verifyEmail,
        builder: (context, state) => const VerifyEmailPage(),
      ),

      GoRoute(
        path: '/reAuthenticationPage',
        name: RoutesNames.reAuthenticationPage,
        builder: (context, state) => const ReAuthenticationPage(),
      ),

      ///
    ],

    /// 🛑 Error screen on unmatched route
    /// Displays a [PageNotFound] error screen with the route error details.
    errorBuilder:
        (context, state) => PageNotFound(errorMessage: state.error.toString()),
  );
}
