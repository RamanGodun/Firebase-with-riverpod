import 'package:go_router/go_router.dart';
import '../../../../features/profile/presentation/profile__page.dart';
import '../../../../features/auth/change_password/presentation/change_password_page.dart';
import '../../../../features/auth/reset_password/presentation/reset_password_page.dart';
import '../../../../features/auth/sign_in/presentation/signin_page.dart';
import '../../../../features/auth/sign_up/presentation/signup_page.dart';
import '../../../../features/auth/change_password/presentation/reauth_page.dart';
import '../../../../features/auth/user_validation/presentation/user_validation_page.dart';
import '../../../layers_shared/presentation_layer_shared/pages_shared/firebase_error_page.dart';
import '../../../layers_shared/presentation_layer_shared/widgets_shared/mini_widgets.dart';
import '../../../layers_shared/presentation_layer_shared/pages_shared/_home_page.dart';
import '../routes_names.dart';

abstract final class AppRoutes {
  AppRoutes._();

  ///
  static final List<GoRoute> all = [
    GoRoute(
      path: '/splash',
      name: RoutesNames.splash,
      builder: (context, state) => const MiniWidgets(MWType.loading),
    ),

    GoRoute(
      path: '/home',
      name: RoutesNames.home,
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'profile',
          name: RoutesNames.profile,
          builder: (context, state) => const ProfilePage(),
          routes: [
            GoRoute(
              path: 'profile/changePassword',
              name: RoutesNames.changePassword,
              builder: (context, state) => const ChangePasswordPage(),
            ),
          ],
        ),
      ],
    ),

    GoRoute(
      path: '/signin',
      name: RoutesNames.signIn,
      builder: (context, state) => const SignInPage(),
    ),

    GoRoute(
      path: '/signup',
      name: RoutesNames.signUp,
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
      name: RoutesNames.reAuthentication,
      builder: (context, state) => const ReAuthenticationPage(),
    ),

    GoRoute(
      path: '/firebaseError',
      name: RoutesNames.firebaseError,
      builder: (context, state) => const FirebaseErrorPage(),
    ),
    //
  ];

  //
}
