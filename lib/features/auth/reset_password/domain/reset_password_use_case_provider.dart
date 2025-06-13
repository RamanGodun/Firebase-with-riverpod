import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/general_utils/typedef.dart';
import '../../../../core/shared_modules/errors_handling/utils/for_riverpod/failure_utils.dart';
import '../data/reset_password_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'reset_password_repo_contract.dart';

part 'reset_password_use_case_provider.g.dart';

/// 🧩 [resetPasswordUseCaseProvider] — provides instance of [ResetPasswordUseCase]
/// 🧼 Uses [resetPasswordRepoProvider] as dependency

@riverpod
ResetPasswordUseCase resetPasswordUseCase(Ref ref) {
  //─────------------------------------------------

  final repo = ref.watch(resetPasswordRepoProvider);
  return ResetPasswordUseCase(repo);
}

///

///

/// 📦 [ResetPasswordUseCase] — encapsulates password reset logic
/// 🧼 Sends password reset email via [IResetPasswordRepo]

final class ResetPasswordUseCase {
  //─────------------------------

  final IResetPasswordRepo repo;
  const ResetPasswordUseCase(this.repo);

  /// 📩 Sends reset link to the provided email
  ResultFuture<void> call(String email) async {
    try {
      await repo.sendResetLink(email);
      return right(null);
    } catch (e, st) {
      return left(mapToFailure(e, st));
    }
  }

  //
}
