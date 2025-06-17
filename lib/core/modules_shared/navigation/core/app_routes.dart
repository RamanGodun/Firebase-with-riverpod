import 'package:firebase_with_riverpod/core/layers_shared/presentation_layer_shared/widgets_shared/loader.dart';
import 'package:go_router/go_router.dart';
import '../../../../features/profile/presentation/profile__page.dart';
import '../../../../features/auth/change_password/presentation/change_password_page.dart';
import '../../../../features/auth/reset_password/presentation/reset_password_page.dart';
import '../../../../features/auth/sign_in/presentation/signin_page.dart';
import '../../../../features/auth/sign_up/presentation/signup_page.dart';
import '../../../../features/auth/change_password/presentation/reauth_page.dart';
import '../../../../features/auth/user_validation/presentation/user_validation_page.dart';
import '../../../layers_shared/presentation_layer_shared/pages_shared/page_not_found.dart';
import '../../../layers_shared/presentation_layer_shared/pages_shared/_home_page.dart';
import 'routes_names.dart';
import '../utils/page_transition.dart';

/// 🧭 [AppRoutes] — Centralized list of all GoRouter routes
/// ✅ Used in [goRouter] and matches [RoutesNames]

abstract final class AppRoutes {
  ///-------------------------

  AppRoutes._();

  ///

  static final List<GoRoute> all = [
    /// ⏳ Splash Page
    GoRoute(
      path: '/splash',
      name: RoutesNames.splash,
      builder: (context, state) => const Loader(),
    ),

    /// 🏠 Home Page
    GoRoute(
      path: '/home',
      name: RoutesNames.home,
      pageBuilder: (context, state) => AppTransitions.fade(const HomePage()),
      routes: [
        /// 👤 Profile Page (Nested under Home)
        GoRoute(
          path: 'profile',
          name: RoutesNames.profile,
          pageBuilder:
              (context, state) => AppTransitions.fade(const ProfilePage()),
          routes: [
            /// 👤  Change password Page (Nested under Profile page)
            GoRoute(
              path: 'profile/changePassword',
              name: RoutesNames.changePassword,
              // builder: (context, state) => const ChangePasswordPage(),
              pageBuilder:
                  (context, state) =>
                      AppTransitions.fade(const ChangePasswordPage()),
            ),
          ],
        ),
      ],
    ),

    /// 🔐 Auth Pages
    GoRoute(
      path: '/signin',
      name: RoutesNames.signIn,
      // builder: (context, state) => const SignInPage(),
      pageBuilder: (context, state) => AppTransitions.fade(const SignInPage()),
    ),

    GoRoute(
      path: '/signup',
      name: RoutesNames.signUp,
      // builder: (context, state) => const SignupPage(),
      pageBuilder: (context, state) => AppTransitions.fade(const SignupPage()),
    ),

    GoRoute(
      path: '/resetPassword',
      name: RoutesNames.resetPassword,
      // builder: (context, state) => const ResetPasswordPage(),
      pageBuilder:
          (context, state) => AppTransitions.fade(const ResetPasswordPage()),
    ),

    GoRoute(
      path: '/verifyEmail',
      name: RoutesNames.verifyEmail,
      // builder: (context, state) => const VerifyEmailPage(),
      pageBuilder:
          (context, state) => AppTransitions.fade(const VerifyEmailPage()),
    ),

    GoRoute(
      path: '/reAuthenticationPage',
      name: RoutesNames.reAuthentication,
      // builder: (context, state) => const ReAuthenticationPage(),
      pageBuilder:
          (context, state) => AppTransitions.fade(const ReAuthenticationPage()),
    ),

    ///

    /// ❌ Error / 404 Page
    GoRoute(
      path: '/${RoutesNames.pageNotFound}',
      name: RoutesNames.pageNotFound,
      pageBuilder:
          (context, state) => AppTransitions.fade(
            const PageNotFound(errorMessage: 'Page not found'),
          ),
    ),

    //
  ];

  //
}
