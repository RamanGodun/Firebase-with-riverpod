import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data_providers/change_password_repo_provider.dart';
import '../../domain/auth_use_cases.dart';

part 'change_password_provider.g.dart';

/// 🧩 [changePasswordProvider] — async notifier that handles change password logic
//--------------------------------------------------------

@riverpod
class ChangePassword extends _$ChangePassword {
  @override
  FutureOr<void> build() {}

  /// 🔁 Triggers password change operation
  Future<void> changePassword(String newPassword) async {
    state = const AsyncLoading();

    /// Delegates actual logic to [ChangePasswordUseCase]
    final repo = ref.read(changePasswordRepoProvider);
    final useCase = ChangePasswordUseCase(repo);

    /// Uses `AsyncValue.guard()` for safe error handling
    state = await AsyncValue.guard(() => useCase(newPassword));
    //
  }
}
