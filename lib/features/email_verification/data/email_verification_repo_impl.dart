import 'package:firebase_with_riverpod/core/shared_data_layer/base_repo.dart';
import '../../../core/shared_domain_layer/shared_auth/auth_user_utils.dart';
import '../domain/email_verification_repo_contract.dart';

/// 🧩 [IUserValidationRepoImpl] — concrete implementation of [IUserValidationRepo]
/// 🧼 Handles email verification operations using FirebaseAuth
//
final class IUserValidationRepoImpl implements IUserValidationRepo {
  ///--------------------------------------------------------------

  @override
  Future<void> sendEmailVerification() =>
      (() async {
        final user = AuthUserUtils.currentUserOrThrow;
        await user.sendEmailVerification();
      }).runWithErrorLog();

  @override
  Future<void> reloadUser() =>
      (() async {
        final user = AuthUserUtils.currentUserOrThrow;
        await user.reload();
      }).runWithErrorLog();

  @override
  bool isEmailVerified() {
    return AuthUserUtils.currentUserOrThrow.emailVerified;
  }

  //
}
