import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../../core/base_modules/form_fields/input_validation/validation_enums.dart';
import 'change_password_form_state.dart';

part 'change_password_form_provider.g.dart';

/// 🧩 [ChangePasswordForm] — Manages the state of the change passford form using [StateNotifier].
/// Handles input updates, validation, and visibility toggling for password field.
//
@riverpod
final class ChangePasswordForm extends _$ChangePasswordForm {
  ///------------------------------------------------

  /// 🧱 Initializes the form with pure input values
  @override
  ChangePasswordFormState build() => const ChangePasswordFormState();

  /// 📝 Updates [password] and revalidates [confirmPassword]
  void passwordChanged(String value) {
    final pwd = PasswordInputValidation.dirty(value);
    state = state.copyWith(password: pwd).updateConfirmPasswordValidation();
  }

  /// 📝 Updates [confirmPassword] and recalculates [isValid]
  void confirmPasswordChanged(String value) {
    final confirm = ConfirmPasswordInputValidation.dirty(
      value: value,
      password: state.password.value,
    );
    state = state.copyWith(confirmPassword: confirm).validate();
  }

  /// 👁️ Toggles password field visibility
  void togglePasswordVisibility() =>
      state = state.copyWith(isPasswordObscure: !state.isPasswordObscure);

  /// 👁️ Toggles confirm password field visibility
  void toggleConfirmPasswordVisibility() =>
      state = state.copyWith(
        isConfirmPasswordObscure: !state.isConfirmPasswordObscure,
      );

  /// ✅ Triggers validation manually (e.g., before submit)
  void validate() {
    state = state.validate();
  }

  /// ♻️ Resets the form to initial state
  void reset() => state = const ChangePasswordFormState();

  //
}
