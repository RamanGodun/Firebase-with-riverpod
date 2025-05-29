// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// import '../../../../features/auth/_domain_data/auth_repository_providers.dart';
// import '../../../../features/profile/presentation/profile_page.dart';
// import '../../config/bootstrap/firebase/firebase_constants.dart';
// import '../../../../features/auth/change_password/change_password_page.dart';
// import '../../../../features/auth/reset_password/reset_password_page.dart';
// import '../../../../features/auth/sign_in/signin_page.dart';
// import '../../../../features/auth/sign_up/signup_page.dart';
// import '../../../../features/auth/user_validation/reauthenticate_page.dart';
// import '../../../../features/auth/user_validation/verify_email_page.dart';
// import '../../shared_presentation/pages/firebase_error_page.dart';
// import '../../shared_presentation/pages/page_not_found.dart';
// import '../../shared_presentation/widgets/mini_widgets.dart';
// import '../../shared_presentation/pages/_home_page.dart';
// import 'routes_names.dart';

// part 'router.g.dart';

// /// 🧭 [routerProvider] — GoRouter provider with dynamic auth-aware redirects
// /// 🔐 Listens to Firebase auth state and automatically redirects:
// ///   - 🚪 to `/signin` if not authenticated
// ///   - 🧪 to `/verifyEmail` if email not verified
// ///   - 🧯 to `/firebaseError` on auth stream error
// ///   - ⏳ to `/splash` while loading
// ///   - ✅ to `/home` when authenticated and verified
// //----------------------------------------------------------------//
// @riverpod
// GoRouter router(Ref ref) {
//   final authState = ref.watch(authStateStreamProvider);

//   return GoRouter(
//     initialLocation: '/splash',

//     /// 🔁 Global redirect based on auth state
//     redirect: (context, state) {
//       if (authState is AsyncLoading<User?>) return '/splash';
//       if (authState is AsyncError<User?>) return '/firebaseError';

//       final isAuthenticated = authState.valueOrNull != null;
//       final isVerified = fbAuth.currentUser?.emailVerified ?? false;

//       final isOnAuth = [
//         '/signin',
//         '/signup',
//         '/resetPassword',
//       ].contains(state.matchedLocation);

//       final isOnVerify = state.matchedLocation == '/verifyEmail';
//       final isOnSplash = state.matchedLocation == '/splash';

//       if (!isAuthenticated) {
//         return isOnAuth ? null : '/signin';
//       }

//       if (!isVerified) {
//         return isOnVerify ? null : '/verifyEmail';
//       }

//       if (isOnAuth || isOnSplash || isOnVerify) {
//         return '/home';
//       }

//       return null;
//     },

//     /// 🗺️ App Route Definitions
//     routes: [
//       GoRoute(
//         path: '/splash',
//         name: RoutesNames.splash,
//         builder: (context, state) => const MiniWidgets(MWType.loading),
//       ),

//       GoRoute(
//         path: '/home',
//         name: RoutesNames.home,
//         builder: (context, state) => const HomePage(),
//         routes: [
//           GoRoute(
//             path: 'profile',
//             name: RoutesNames.profilePage,
//             builder: (context, state) => const ProfilePage(),
//             routes: [
//               GoRoute(
//                 path: 'profile/changePassword',
//                 name: RoutesNames.changePassword,
//                 builder: (context, state) => const ChangePasswordPage(),
//               ),
//             ],
//           ),
//         ],
//       ),

//       GoRoute(
//         path: '/signin',
//         name: RoutesNames.signin,
//         builder: (context, state) => const SignInPage(),
//       ),

//       GoRoute(
//         path: '/signup',
//         name: RoutesNames.signup,
//         builder: (context, state) => const SignupPage(),
//       ),

//       GoRoute(
//         path: '/resetPassword',
//         name: RoutesNames.resetPassword,
//         builder: (context, state) => const ResetPasswordPage(),
//       ),

//       GoRoute(
//         path: '/verifyEmail',
//         name: RoutesNames.verifyEmail,
//         builder: (context, state) => const VerifyEmailPage(),
//       ),

//       GoRoute(
//         path: '/reAuthenticationPage',
//         name: RoutesNames.reAuthenticationPage,
//         builder: (context, state) => const ReAuthenticationPage(),
//       ),

//       GoRoute(
//         path: '/firebaseError',
//         name: RoutesNames.firebaseError,
//         builder: (context, state) => const FirebaseErrorPage(),
//       ),
//     ],

//     /// 🛑 Wildcard error route
//     errorBuilder:
//         (context, state) => PageNotFound(errorMessage: state.error.toString()),
//   );
// }