import 'package:firebase_with_riverpod/core/shared_domain_layer/base_use_case.dart';
import '../../../core/utils_shared/type_definitions.dart';
import '../domain/repo_contract.dart';
import 'password_actions_remote_data_source.dart';

/// 🧩 [PasswordRepoImpl] — concrete implementation of [IPasswordRepo]
/// 🧼 Uses FirebaseAuth for all password-related operations
//
final class PasswordRepoImpl implements IPasswordRepo {
  final IPasswordRemoteDataSource _remote;

  const PasswordRepoImpl(this._remote);

  @override
  ResultFuture<void> changePassword(String newPassword) =>
      (() => _remote.changePassword(newPassword)).executeWithFailureHandling();

  @override
  ResultFuture<void> sendResetLink(String email) =>
      (() => _remote.sendResetLink(email)).executeWithFailureHandling();
}


/*


final class PasswordRepoImpl implements IPasswordRepo {
  ///-------------------------------------------------------------

  /// Throws [FirebaseAuthException] if no user is signed in
  @override
  ResultFuture<void> changePassword(String newPassword) =>
      (() async {
        final user = AuthUserUtils.currentUserOrThrow;
        await user.updatePassword(newPassword);
      }).executeWithFailureHandling();

  ///
  @override
  ResultFuture<void> sendResetLink(String email) =>
      (() => fbAuth.sendPasswordResetEmail(email: email))
          .executeWithFailureHandling();

  //
}



 */