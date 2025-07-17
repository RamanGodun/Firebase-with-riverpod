import '../../../core/base_modules/errors_handling/utils/failure_handling.dart';
import '../../../core/utils_shared/type_definitions.dart';
import '../domain/email_verification_repo_contract.dart';
import 'remote_data_source.dart';

/// 🧩 [IUserValidationRepoImpl] — Repo for email verification, applies error mapping and delegates to [IUserValidationRemoteDataSource]
//
final class IUserValidationRepoImpl implements IUserValidationRepo {
  ///------------------------------------------------------------
  //
  final IUserValidationRemoteDataSource _remote;
  const IUserValidationRepoImpl(this._remote);

  /// 📧 Sends verification email via [IUserValidationRemoteDataSource]
  @override
  ResultFuture<void> sendEmailVerification() =>
      (() => _remote.sendVerificationEmail()).executeWithFailureHandling();

  /// 🔁 Reloads current user from [IUserValidationRemoteDataSource]
  @override
  ResultFuture<void> reloadUser() =>
      (() => _remote.reloadUser()).executeWithFailureHandling();

  /// ✅ Checks if user's email is verified
  @override
  ResultFuture<bool> isEmailVerified() =>
      (() async => _remote.isEmailVerified()).executeWithFailureHandling();

  //
}
