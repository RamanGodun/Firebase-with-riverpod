import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data_providers/reset_password_repo_provider.dart';
import '../../domain/auth_use_cases.dart';

part 'reset_password_provider.g.dart';

/// 🧩 [changePasswordProvider] — async notifier that handles change password logic
//----------------------------------------------------------------

@riverpod
class ResetPassword extends _$ResetPassword {
  @override
  FutureOr<void> build() {}

  /// 📩 Sends password reset email using [AuthRepository]
  Future<void> resetPassword({required String email}) async {
    state = const AsyncLoading();

    final repo = ref.read(resetPasswordRepoProvider);
    final useCase = ResetPasswordUseCase(repo);

    /// Uses [AsyncValue.guard()] for error-safe execution
    state = await AsyncValue.guard(() => useCase(email));
  }
}
