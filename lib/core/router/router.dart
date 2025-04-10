import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/change_password/change_password_page.dart';
import '../../presentation/pages/firebase_error_page.dart';
import '../../presentation/pages/page_not_found.dart';
import '../../features/reset_password/reset_password_page.dart';
import '../../features/sign_in/signin_page.dart';
import '../../features/sign_up/signup_page.dart';
import '../../presentation/pages/verify_email_page.dart';
import '../../presentation/widgets/mini_widgets.dart';
import '../../data/repositories/auth/auth_repository_provider.dart';
import '../../data/sources/remote/consts/firebase_constants.dart';
import '../../features/home_page/home_page.dart';
import 'routes_names.dart';

part 'router.g.dart';

/// **Router Provider**
///
/// This provider manages the app's navigation using [GoRouter].
/// It listens to the authentication state and dynamically redirects users
/// to the appropriate screens based on their authentication status and email verification state.
@riverpod
GoRouter router(Ref ref) {
  final authState = ref.watch(authStateStreamProvider);

  return GoRouter(
    initialLocation: '/splash',

    /// **Redirect Logic**
    ///
    /// - If auth state is **loading**, navigate to `/splash`
    /// - If auth state has an **error**, navigate to `/firebaseError`
    /// - If user is **not authenticated**, redirect to `/signin` (unless already on an auth screen)
    /// - If email is **not verified**, redirect to `/verifyEmail`
    /// - Otherwise, navigate to `/home`
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

    /// **Route Definitions**
    routes: [
      /// **Splash Screen**
      GoRoute(
        path: '/splash',
        name: RoutesNames.splash,
        builder: (context, state) => const AppMiniWidgets(MWType.loading),
      ),

      /// **Firebase Error Page**
      GoRoute(
        path: '/firebaseError',
        name: RoutesNames.firebaseError,
        builder: (context, state) => const FirebaseErrorPage(),
      ),

      /// **Authentication Screens**
      GoRoute(
        path: '/signin',
        name: RoutesNames.signin,
        builder: (context, state) => const SigninPage(),
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

      /// **Home Screen & Nested Routes**
      GoRoute(
        path: '/home',
        name: RoutesNames.home,
        builder: (context, state) => const HomePage(),
        routes: [
          /// **Change Password Screen (Nested under Home)**
          GoRoute(
            path: 'changePassword',
            name: RoutesNames.changePassword,
            builder: (context, state) => const ChangePasswordPage(),
          ),
        ],
      ),
    ],

    /// **Error Handling**
    ///
    /// Displays a **Page Not Found** error screen with the route error details.
    errorBuilder:
        (context, state) => PageNotFound(errorMessage: state.error.toString()),
  );
}
