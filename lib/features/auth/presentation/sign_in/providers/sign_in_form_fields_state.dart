import 'package:equatable/equatable.dart' show Equatable;
import 'package:formz/formz.dart' show Formz;
import '../../../../form_fields/input_validation/_validation_enums.dart';

/// 📦 [SignInFormState] — Immutable model representing the state of the sign-in form.
/// Tracks field values, password visibility, and overall form validity.
//
final class SignInFormState extends Equatable {
  ///---------------------------------------

  final EmailInputValidation email;
  final PasswordInputValidation password;
  final bool isPasswordObscure;
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

  ///
  @override
  List<Object> get props => [email, password, isPasswordObscure, isValid];

  //
}
