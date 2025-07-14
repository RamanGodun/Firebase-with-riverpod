import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../app_bootstrap_and_config/app_config/firebase/firebase_constants.dart';
import '../../../../core/base_modules/errors_handling/utils/observers/loggers/errors_log_util.dart';
import '../domain/reset_password_repo_contract.dart';

part 'reset_password_repo_provider.g.dart';

/// 🧩 [resetPasswordRepoProvider] — provides instance of [ResetPasswordRepoImpl]
/// 🧼 Dependency injection for password reset functionality

@riverpod
IResetPasswordRepo resetPasswordRepo(Ref ref) => ResetPasswordRepoImpl();

////

////

/// 🧩 [ResetPasswordRepoImpl] — concrete implementation of [IResetPasswordRepo]
/// 🧼 Uses FirebaseAuth to send reset email

final class ResetPasswordRepoImpl implements IResetPasswordRepo {
  ///-----------------------------------------------------------

  @override
  Future<void> sendResetLink(String email) async {
    //
    try {
      await fbAuth.sendPasswordResetEmail(email: email);
    } catch (e, st) {
      ErrorsLogger.log(e, st);
      rethrow;
    }
    //
  }

  //
}
