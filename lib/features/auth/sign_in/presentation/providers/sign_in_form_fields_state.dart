import 'package:formz/formz.dart' show Formz;
import '../../../../form_fields/input_validation/_validation_enums.dart';

/// 📦 [SignInFormState] — Immutable model representing the state of the sign-in form.
/// Tracks field values, password visibility, and overall form validity.

class SignInFormState {
  ///----------------

  // Formz input for validating user email
  final EmailInputValidation email;
  // Current value of the password input field.
  final PasswordInputValidation password;
  // Whether the password should be obscured (hidden).
  final bool isPasswordObscure;
  // Whether the form is valid (all inputs are valid).
  final bool isValid;

  /// Creates a new [SignInFormState] instance.
  const SignInFormState({
    this.email = const EmailInputValidation.pure(),
    this.password = const PasswordInputValidation.pure(),
    this.isPasswordObscure = true,
    this.isValid = false,
  });

  /// Returns a new copy of this state with updated fields.
  SignInFormState copyWith({
    EmailInputValidation? email,
    PasswordInputValidation? password,
    bool? isPasswordObscure,
    bool? isValid,
  }) {
    return SignInFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
      isValid: isValid ?? this.isValid,
    );
  }

  /// Validates all input fields and updates the `isValid` flag accordingly.
  SignInFormState validate() {
    final valid = Formz.validate([email, password]);
    return copyWith(isValid: valid);
  }

  //
}
