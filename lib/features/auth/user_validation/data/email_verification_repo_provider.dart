import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/shared_modules/errors_handling/utils/observers/loggers/errors_log_util.dart';
import '../../utils/auth_user_utils.dart';
import '../domain/user_validation_repo_contract.dart';

part 'email_verification_repo_provider.g.dart';

/// 🧩 [emailVerificationRepoProvider] — provides instance of [IUserValidationRepoImpl]
/// 🧼 Dependency injection for email verification functionality

@riverpod
IUserValidationRepo emailVerificationRepo(Ref ref) => IUserValidationRepoImpl();

///

///

/// 🧩 [IUserValidationRepoImpl] — concrete implementation of [IUserValidationRepo]
/// 🧼 Handles email verification operations using FirebaseAuth

final class IUserValidationRepoImpl implements IUserValidationRepo {
  ///--------------------------------------------------------------

  @override
  Future<void> sendEmailVerification() async {
    try {
      final user = AuthUserUtils.currentUserOrThrow;
      await user.sendEmailVerification();
    } on FirebaseAuthException catch (e, st) {
      ErrorsLogger.log(e, st);
      rethrow;
    }
  }

  @override
  Future<void> reloadUser() async {
    try {
      final user = AuthUserUtils.currentUserOrThrow;
      await user.reload();
    } on FirebaseAuthException catch (e, st) {
      ErrorsLogger.log(e, st);
      rethrow;
    }
  }

  @override
  bool isEmailVerified() {
    return AuthUserUtils.currentUserOrThrow.emailVerified;
  }

  //
}
