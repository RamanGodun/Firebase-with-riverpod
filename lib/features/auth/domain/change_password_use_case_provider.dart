import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/shared_modules/errors_handling/utils/for_riverpod/failure_utils.dart';
import '../../../core/utils/typedef.dart';
import '../data_providers/change_password_repo_provider.dart';
import 'auth_repos.dart';

part 'change_password_use_case_provider.g.dart';

/// 🧩 [changePasswordUseCaseProvider] — provides instance of [ChangePasswordUseCase]
/// 🧼 Depends on [changePasswordRepoProvider] for implementation
@riverpod
ChangePasswordUseCase changePasswordUseCase(Ref ref) {
  final repo = ref.watch(changePasswordRepoProvider);
  return ChangePasswordUseCase(repo);
}

///

/// 📦 [ChangePasswordUseCase] — encapsulates password change logic
/// 🧼 Handles Firebase logic with failure mapping
final class ChangePasswordUseCase {
  //
  final IChangePasswordRepo repo;
  const ChangePasswordUseCase(this.repo);

  /// 🔁 Triggers password change and wraps result
  ResultFuture<void> call(String newPassword) async {
    try {
      await repo.changePassword(newPassword);
      return right(null);
    } catch (e, st) {
      return left(mapToFailure(e, st));
    }
  }
}
