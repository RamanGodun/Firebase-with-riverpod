import '../../../core/base_modules/errors_handling/utils/for_riverpod/failure_utils.dart';
import '../../../core/utils_shared/type_definitions.dart';
import 'repo_contract.dart';

/// 📦 [PasswordRelatedUseCases] — encapsulates password related logic
/// 🧼 Handles Firebase logic with failure mapping

final class PasswordRelatedUseCases {
  ///-----------------------------

  final IPasswordRepo repo;
  const PasswordRelatedUseCases(this.repo);

  /// 🔁 Triggers password change and wraps result
  // Throws [FirebaseAuthException] if no user is signed in
  ResultFuture<void> callChangePassword(String newPassword) async {
    try {
      await repo.changePassword(newPassword);
      return right(null);
    } catch (e, st) {
      return left(mapToFailure(e, st));
    }
  }

  /// 📩 Sends reset link to the provided email
  ResultFuture<void> callResetPassword(String email) async {
    try {
      await repo.sendResetLink(email);
      return right(null);
    } catch (e, st) {
      return left(mapToFailure(e, st));
    }
  }

  //
}
