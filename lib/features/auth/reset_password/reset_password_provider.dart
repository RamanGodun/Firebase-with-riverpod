import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../_data/auth_repository_providers.dart';

part 'reset_password_provider.g.dart';

/// 🧩 [resetPasswordProvider] — async notifier for password reset logic
/// 🧼 Incapsulates logic for triggering reset flow via [AuthRepository]
//----------------------------------------------------------------//

@riverpod
class ResetPassword extends _$ResetPassword {
  @override
  FutureOr<void> build() {}

  /// 📩 Sends password reset email using [AuthRepository]
  Future<void> resetPassword({required String email}) async {
    state = const AsyncLoading();

    /// Uses [AsyncValue.guard()] for error-safe execution
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).sendPasswordResetEmail(email),
    );
  }
}
