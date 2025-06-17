import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/utils_shared/typedef.dart';
import '../../../../core/modules_shared/errors_handling/utils/for_riverpod/failure_utils.dart';
import '../data/email_verification_repo_provider.dart';
import 'user_validation_repo_contract.dart';

part 'user_validation_use_case_provider.g.dart';

/// 🧩 [emailVerificationUseCaseProvider] — provides [EmailVerificationUseCase]

@riverpod
EmailVerificationUseCase emailVerificationUseCase(Ref ref) {
  //-------------------------------------------------------

  final repo = ref.watch(emailVerificationRepoProvider);
  return EmailVerificationUseCase(repo);
}

///

///

/// 📦 [EmailVerificationUseCase] — encapsulates email verification logic
/// 🧼 Handles send + reload + check via Firebase

final class EmailVerificationUseCase {
  //---------------------------------

  final IUserValidationRepo repo;
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
