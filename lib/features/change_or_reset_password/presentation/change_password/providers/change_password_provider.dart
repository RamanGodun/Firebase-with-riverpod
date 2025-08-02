import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/base_modules/errors_handling/core_of_module/failure_entity.dart';
import '../../../../../core/base_modules/localization/generated/locale_keys.g.dart';
import '../../../domain/provider/use_cases_provider.dart';
import 'package:easy_localization/easy_localization.dart';

part 'change_password_state.dart';

/// 🧩 [changePasswordProvider] — Manages the state and logic for password change flow.
/// Handles password update process, error mapping, and reauthentication scenarios.
//
final changePasswordProvider =
    StateNotifierProvider<ChangePasswordNotifier, ChangePasswordState>(
      (ref) => ChangePasswordNotifier(ref),
    );

/// 🛡️ [ChangePasswordNotifier] — StateNotifier handling password change process.
/// Updates state for loading, success, error, and reauth cases.
//
final class ChangePasswordNotifier extends StateNotifier<ChangePasswordState> {
  final Ref ref;
  String? _pendingPassword;

  /// 🧱 Initializes with [ChangePasswordInitial] state
  ChangePasswordNotifier(this.ref) : super(const ChangePasswordInitial());

  /// 🔁 Attempts to update the user password via [ChangePasswordUseCase].
  /// Emits [ChangePasswordLoading], then [ChangePasswordSuccess], [ChangePasswordError], or [ChangePasswordRequiresReauth].
  Future<void> changePassword(String newPassword) async {
    state = const ChangePasswordLoading();

    final useCase = ref.read(passwordUseCasesProvider);
    final result = await useCase.callChangePassword(newPassword);

    result.fold(
      (failure) {
        if (failure.code == 'requires-recent-login') {
          state = const ChangePasswordRequiresReauth();
        } else {
          state = ChangePasswordError(failure);
        }
      },
      (_) =>
          state = ChangePasswordSuccess(
            LocaleKeys.reauth_password_updated.tr(),
          ),
    );
  }

  /// ♻️ Retries password update after user reauthenticates.
  /// Uses stored [_pendingPassword] for retry logic.
  Future<void> retryAfterReauth() async {
    final pwd = _pendingPassword;
    if (pwd == null) return;
    state = const ChangePasswordLoading();

    final useCase = ref.read(passwordUseCasesProvider);
    final result = await useCase.callChangePassword(pwd);

    result.fold(
      (failure) {
        state = ChangePasswordError(failure);
      },
      (_) =>
          state = ChangePasswordSuccess(
            LocaleKeys.reauth_password_updated.tr(),
          ),
    );
  }
}
