import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/email_verification_repo_provider.dart';
import '../../../core/utils_shared/type_definitions.dart';
import 'email_verification_repo_contract.dart';

part 'email_verification_use_case_provider.g.dart';

/// 🧩 [emailVerificationUseCaseProvider] — provides [EmailVerificationUseCase]
//
@riverpod
EmailVerificationUseCase emailVerificationUseCase(Ref ref) {
  ///---------------------------------------------------
  //
  final repo = ref.watch(emailVerificationRepoProvider);
  return EmailVerificationUseCase(repo);
}

////

////

////

/// 📦 [EmailVerificationUseCase] — encapsulates email verification logic
//
final class EmailVerificationUseCase {
  ///------------------------------
  //
  final IUserValidationRepo repo;
  const EmailVerificationUseCase(this.repo);

  /// 📧 Sends verification email
  ResultFuture<void> sendVerificationEmail() => repo.sendEmailVerification();

  /// 📧 Sends verification email
  ResultFuture<void> reloadUser() => repo.reloadUser();

  /// ✅ Checks email verification status
  ResultFuture<bool> checkIfEmailVerified() async {
    await repo.reloadUser();
    return repo.isEmailVerified();
  }

  //
}
