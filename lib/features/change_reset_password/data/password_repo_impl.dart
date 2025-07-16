import 'package:firebase_with_riverpod/core/share_data_layer/base_repo.dart';
import '../../../app_bootstrap_and_config/app_config/firebase/firebase_constants.dart';
import '../../../core/shared_domain_layer/shared_auth/auth_user_utils.dart';
import '../domain/repo_contract.dart';

/// 🧩 [PasswordRepoImpl] — concrete implementation of [IPasswordRepo]
/// 🧼 Uses FirebaseAuth for all password-related operations

final class PasswordRepoImpl implements IPasswordRepo {
  ///-------------------------------------------------------------

  ///
  @override
  Future<void> changePassword(String newPassword) =>
      (() async {
        final user = AuthUserUtils.currentUserOrThrow;
        await user.updatePassword(newPassword);
      }).runWithErrorLog();

  ///
  @override
  Future<void> sendResetLink(String email) =>
      (() => fbAuth.sendPasswordResetEmail(email: email)).runWithErrorLog();

  //
}
