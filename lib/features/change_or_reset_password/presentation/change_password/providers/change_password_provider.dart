import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/base_modules/errors_handling/failures/failure_entity.dart';
import '../../../../../core/base_modules/localization/generated/locale_keys.g.dart';
import '../../../domain/provider/use_cases_provider.dart';

// part 'change_password_provider.g.dart';

/// 🧩 [changePasswordProvider] — Handles password update
//
final changePasswordProvider =
    StateNotifierProvider<ChangePasswordNotifier, ChangePasswordState>(
      (ref) => ChangePasswordNotifier(ref),
    );

////
final class ChangePasswordNotifier extends StateNotifier<ChangePasswordState> {
  final Ref ref;
  String? _pendingPassword;

  ChangePasswordNotifier(this.ref) : super(const ChangePasswordInitial());

  /// 🔁 Updates the user password via [ChangePasswordUseCase]
  /// Triggers `signInWithCredential` or fails with [Failure]
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

  /// ♻️ Retries password update after `reauthentication`
  /// Uses previously stored password to retry safely
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

////

sealed class ChangePasswordState {
  const ChangePasswordState();
}

final class ChangePasswordInitial extends ChangePasswordState {
  const ChangePasswordInitial();
}

final class ChangePasswordLoading extends ChangePasswordState {
  const ChangePasswordLoading();
}

final class ChangePasswordSuccess extends ChangePasswordState {
  final String message;
  const ChangePasswordSuccess(this.message);
}

final class ChangePasswordRequiresReauth extends ChangePasswordState {
  const ChangePasswordRequiresReauth();
}

final class ChangePasswordError extends ChangePasswordState {
  final Failure failure;
  const ChangePasswordError(this.failure);
}

extension ChangePasswordStateX on ChangePasswordState {
  bool get isLoading => this is ChangePasswordLoading;
  bool get isSuccess => this is ChangePasswordSuccess;
  bool get isError => this is ChangePasswordError;
  bool get isRequiresReauth => this is ChangePasswordRequiresReauth;
}
