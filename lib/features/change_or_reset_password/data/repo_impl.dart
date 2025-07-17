import 'package:firebase_with_riverpod/core/base_modules/errors_handling/utils/failure_handling.dart';
import '../../../core/utils_shared/type_definitions.dart';
import '../domain/repo_contract.dart';
import 'current_remote_data_source.dart';

/// 🧩 [PasswordRepoImpl] — Delegates password-related calls to [IPasswordRemoteDataSource]
/// 🧼 Adds unified failure handling via `.executeWithFailureHandling()`
//
final class PasswordRepoImpl implements IPasswordRepo {
  ///-----------------------------------------------
  //
  final IPasswordRemoteDataSource _remote;
  const PasswordRepoImpl(this._remote);

  /// 🔁 Changes password for the currently signed-in user
  @override
  ResultFuture<void> changePassword(String newPassword) =>
      (() => _remote.changePassword(newPassword)).executeWithFailureHandling();

  /// 📩 Sends reset password link to provided email
  @override
  ResultFuture<void> sendResetLink(String email) =>
      (() => _remote.sendResetLink(email)).executeWithFailureHandling();

  //
}
