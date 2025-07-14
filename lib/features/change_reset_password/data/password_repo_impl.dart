

import '../../../app_bootstrap_and_config/app_config/firebase/firebase_constants.dart';
import '../../../core/base_modules/errors_handling/utils/observers/loggers/errors_log_util.dart';
import '../../../core/shared_domain_layer/shared_auth/auth_user_utils.dart';
import '../domain/repo_contract.dart';

/// 🧩 [PasswordRepoImpl] — concrete implementation of [IPasswordRepo]
/// 🧼 Uses FirebaseAuth for all password-related operations

final class PasswordRepoImpl implements IPasswordRepo {
  ///-------------------------------------------------------------

  ///
  @override
  Future<void> changePassword(String newPassword) async {
    try {
      final user = AuthUserUtils.currentUserOrThrow;
      await user.updatePassword(newPassword);
    } catch (e, st) {
      ErrorsLogger.log(e, st);
      rethrow;
    }
  }

  ///
  @override
  Future<void> sendResetLink(String email) async {
    try {
      await fbAuth.sendPasswordResetEmail(email: email);
    } catch (e, st) {
      ErrorsLogger.log(e, st);
      rethrow;
    }
  }

  //
}
