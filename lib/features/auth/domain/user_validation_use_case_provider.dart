import 'package:firebase_with_riverpod/features/auth/domain/auth_repos.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/shared_modules/errors_handling/utils/for_riverpod/failure_utils.dart';
import '../../../core/utils/typedef.dart';
import '../data_providers/email_verification_repo_provider.dart';

part 'user_validation_use_case_provider.g.dart';

/// 🧩 [emailVerificationUseCaseProvider] — provides [EmailVerificationUseCase]
@riverpod
EmailVerificationUseCase emailVerificationUseCase(Ref ref) {
  final repo = ref.watch(emailVerificationRepoProvider);
  return EmailVerificationUseCase(repo);
}

/// 📦 [EmailVerificationUseCase] — encapsulates email verification logic
/// 🧼 Handles send + reload + check via Firebase
final class EmailVerificationUseCase {
  final IEmailVerificationRepo repo;
  const EmailVerificationUseCase(this.repo);

  /// 📧 Sends verification email
  ResultFuture<void> sendVerificationEmail() async {
    try {
      await repo.sendEmailVerification();
      return right(null);
    } catch (e, st) {
      return left(mapToFailure(e, st));
    }
  }

  /// ✅ Checks email verification status
  ResultFuture<bool> checkIfEmailVerified() async {
    try {
      await repo.reloadUser();
      return right(repo.isEmailVerified());
    } catch (e, st) {
      return left(mapToFailure(e, st));
    }
  }

  //
}
