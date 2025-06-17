import 'package:flutter/foundation.dart' show debugPrint;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/modules_shared/errors_handling/utils/for_riverpod/safe_async_state.dart';
import '../domain/change_password_use_case_provider.dart';

part 'change_password_provider.g.dart';

/// 🧩 [changePasswordProvider] — async notifier that handles password update
/// 🧼 Uses [SafeAsyncState] to prevent post-dispose state updates
/// 🧼 Wraps logic in [AsyncValue.guard] for robust error handling

@riverpod
class ChangePassword extends _$ChangePassword with SafeAsyncState<void> {
  ///----------------------------------------------------------------

  String? _pendingPassword;

  /// 🧱 Initializes safe lifecycle tracking
  @override
  FutureOr<void> build() {
    initSafe();
  }

  /// 🔁 Updates the user password via [ChangePasswordUseCase]
  /// Triggers `signInWithCredential` or fails with [Failure]
  Future<void> changePassword(String newPassword) async {
    //
    _pendingPassword = newPassword;
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final useCase = ref.watch(changePasswordUseCaseProvider);
      final result = await useCase(newPassword);
      return result.fold((f) => throw f, (_) => null);
    });
  }

  /// ♻️ Retries password update after `reauthentication`
  /// Uses previously stored password to retry safely
  Future<void> retryAfterReauth() async {
    final pwd = _pendingPassword;
    if (pwd == null) return;

    _pendingPassword = null; // ❗
    state = const AsyncLoading();
    debugPrint('[ChangePassword] Retrying password change after reauth');

    state = await AsyncValue.guard(() async {
      final useCase = ref.watch(changePasswordUseCaseProvider);
      final result = await useCase(pwd);
      return result.fold((f) => throw f, (_) => null);
    });
  }

  //
}
