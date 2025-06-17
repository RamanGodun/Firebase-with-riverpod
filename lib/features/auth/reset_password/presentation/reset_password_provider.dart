import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/modules_shared/errors_handling/utils/for_riverpod/safe_async_state.dart';
import '../domain/reset_password_use_case_provider.dart';

part 'reset_password_provider.g.dart';

/// 🧩 [resetPasswordProvider] — async notifier that handles password reset
/// 🧼 Uses [SafeAsyncState] to prevent post-dispose state updates
/// 🧼 Wraps logic in [AsyncValue.guard] for robust error handling

@riverpod
class ResetPassword extends _$ResetPassword with SafeAsyncState<void> {
  //----------------------------------------------------------------

  /// 🧱 Initializes safe lifecycle tracking
  @override
  FutureOr<void> build() {
    initSafe();
  }

  /// 📩 Sends reset link to provided email via [ResetPasswordUseCase]
  /// 🧼 Watches [resetPasswordUseCaseProvider] to access domain logic
  /// ❗ Throws [Failure] if sending fails — handled via `.listen(...)` in UI
  Future<void> resetPassword({required String email}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await updateSafely(() async {
        final useCase = ref.watch(resetPasswordUseCaseProvider);
        final result = await useCase(email);
        return result.fold((f) => throw f, (_) => null);
      });

      return;
    });
  }

  //
}
