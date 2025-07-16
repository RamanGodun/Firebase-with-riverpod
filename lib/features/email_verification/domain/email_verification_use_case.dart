import 'package:firebase_with_riverpod/core/shared_domain_layer/base_use_case.dart';
import '../../../core/utils_shared/type_definitions.dart';
import 'email_verification_repo_contract.dart';

/// 📦 [EmailVerificationUseCase] — encapsulates email verification logic
/// 🧼 Handles send + reload + check via Firebase
//
final class EmailVerificationUseCase {
  ///------------------------------
  //
  final IUserValidationRepo repo;
  const EmailVerificationUseCase(this.repo);

  /// 📧 Sends verification email
  ResultFuture<void> sendVerificationEmail() =>
      (() => repo.sendEmailVerification()).executeWithFailureHandling();

  /// 📧 Sends verification email
  ResultFuture<void> reloadUser() =>
      (() => repo.reloadUser()).executeWithFailureHandling();

  /// ✅ Checks email verification status
  ResultFuture<bool> checkIfEmailVerified() =>
      (() async {
        await repo.reloadUser();
        return repo.isEmailVerified();
      }).executeWithFailureHandling();

  //
}
