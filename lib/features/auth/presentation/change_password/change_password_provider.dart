import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/change_password_repo.dart';
import '../../domain/change_password_use_case.dart';

part 'change_password_provider.g.dart';

/// 🧩 [changePasswordProvider] — async notifier that handles change password logic
//--------------------------------------------------------

@riverpod
class ChangePassword extends _$ChangePassword {
  @override
  FutureOr<void> build() {}

  /// 🔁 Triggers password change operation
  Future<void> changePassword(String password) async {
    state = const AsyncLoading();

    final repo = ref.read(changePasswordRepoProvider);

    /// Delegates actual logic to [ChangePasswordUseCase]
    final useCase = ChangePasswordUseCase(repo);

    /// Uses `AsyncValue.guard()` for safe error handling
    state = await AsyncValue.guard(() => useCase(password));
    //
  }
}
