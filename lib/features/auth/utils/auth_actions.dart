// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../core/shared_modules/errors_handling/failures_for_domain_and_presentation/failure_ui_model.dart';
// import '../../../core/utils/typedef.dart';
// import '../../profile/data/profile_repo_provider.dart';
// import '../presentation/sign_out/sign_out_provider.dart';

// /// 🧩 [AuthActions] — utility class for sign-out UI logic
// /// ✅ Handles logout, overlay error, GoRouter redirect, cache cleanup
// /// ─────────────────────────────────────────────────────────────────────
// final class AuthActions {
//   const AuthActions._();

//   ///
//   static Future<void> signOut({
//     required WidgetRef ref,
//     required ErrorDispatcher onError,
//   }) async {
//     //
//     final notifier = ref.read(signOutProvider.notifier);
//     await notifier.signOut();

//     final failure = ref
//         .read(signOutProvider)
//         .maybeWhen(error: (e, _) => e, orElse: () => null);

//     if (failure case final FailureUIModel model) {
//       onError(model);
//       notifier.reset();
//     }

//     if (ref.read(signOutProvider).hasValue) {
//       ref.read(profileRepoProvider).clearCache();
//     }
//   }

//   ///
// }
