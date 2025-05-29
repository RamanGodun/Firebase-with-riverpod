import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/utils/safe_async_state.dart';
import '../../data_providers/change_password_repo_provider.dart';
import '../../domain/auth_use_cases.dart';

part 'change_password_provider.g.dart';

/// 🧩 [changePasswordProvider] — async notifier that handles password update
/// 🧼 Uses [SafeAsyncState] to prevent state updates after disposal
/// 🧼 Safely wraps logic using [AsyncValue.guard] with lifecycle protection
//--------------------------------------------------------//
@riverpod
class ChangePassword extends _$ChangePassword with SafeAsyncState<void> {
  /// 🧱 Initializes safe state tracking
  @override
  FutureOr<void> build() {
    initSafe();
  }

  /// 🔁 Updates the user password via [ChangePasswordUseCase]
  /// - Executes securely with internal error handling
  Future<void> changePassword(String newPassword) async {
    final repo = ref.read(changePasswordRepoProvider);
    final useCase = ChangePasswordUseCase(repo);

    await updateSafely(() => useCase(newPassword));
  }
}
