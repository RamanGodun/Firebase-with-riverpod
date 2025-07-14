import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../form_fields/input_validation/_validation_enums.dart';
import 'change_password_form_state.dart';

part 'change_password_form_provider.g.dart';

@riverpod
class ChangePasswordForm extends _$ChangePasswordForm {
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
