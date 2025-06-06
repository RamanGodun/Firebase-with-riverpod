import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/shared_modules/errors_handling/utils/for_riverpod/safe_async_state.dart';
import '../../data_providers/reset_password_repo_provider.dart';
import '../../domain/auth_use_cases.dart';

part 'reset_password_provider.g.dart';

/// 🧩 [resetPasswordProvider] — async notifier that handles password reset flow
/// 🧼 Uses [SafeAsyncState] to prevent unsafe post-dispose state updates
/// 🧼 Wraps async call in [AsyncValue.guard] for clean error handling
//----------------------------------------------------------------//
@riverpod
class ResetPassword extends _$ResetPassword with SafeAsyncState<void> {
  /// 🧱 Initializes safe state tracking
  @override
  FutureOr<void> build() {
    initSafe();
  }

  /// 📩 Sends reset link to the provided email
  /// - Delegates to [ResetPasswordUseCase]
  /// - Ensures state is only updated if notifier is still mounted
  Future<void> resetPassword({required String email}) async {
    final repo = ref.read(resetPasswordRepoProvider);
    final useCase = ResetPasswordUseCase(repo);

    await updateSafely(() => useCase(email));
  }
}
