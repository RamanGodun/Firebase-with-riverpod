import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_repos.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data_providers/reset_password_repo_provider.dart';

part 'reset_password_use_case_provider.g.dart';

/// 🧩 [resetPasswordUseCaseProvider] — provides instance of [ResetPasswordUseCase]
/// 🧼 Uses [resetPasswordRepoProvider] as dependency
//─────------------------------------------------------------
@riverpod
ResetPasswordUseCase resetPasswordUseCase(Ref ref) {
  final repo = ref.watch(resetPasswordRepoProvider);
  return ResetPasswordUseCase(repo);
}

///

/// 📦 [ResetPasswordUseCase] — encapsulates password reset logic
/// 🧼 Sends password reset email via [IResetPasswordRepo]
//─────------------------------------------------------------
final class ResetPasswordUseCase {
  //
  final IResetPasswordRepo repo;
  const ResetPasswordUseCase(this.repo);

  /// 📩 Sends reset link to the provided email
  Future<void> call(String email) => repo.sendResetLink(email);
}
