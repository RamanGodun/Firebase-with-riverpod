import 'package:firebase_with_riverpod/core/shared_domain_layer/base_use_case.dart';
import '../../../core/utils_shared/type_definitions.dart';
import 'repo_contract.dart';

/// 📦 [PasswordRelatedUseCases] — encapsulates password related logic
/// 🧼 Handles Firebase logic with failure mapping
//
final class PasswordRelatedUseCases {
  ///-----------------------------

  final IPasswordRepo repo;
  const PasswordRelatedUseCases(this.repo);

  /// 🔁 Triggers password change and wraps result
  // Throws [FirebaseAuthException] if no user is signed in
  ResultFuture<void> callChangePassword(String newPassword) =>
      (() => repo.changePassword(newPassword)).executeWithFailureHandling();

  /// 📩 Sends reset link to the provided email
  ResultFuture<void> callResetPassword(String email) =>
      (() => repo.sendResetLink(email)).executeWithFailureHandling();

  //
}
