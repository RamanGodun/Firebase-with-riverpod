import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import '../../../form_fields/input_validation/_validation_enums.dart';

/// 📦 [SignInFormState] — Стейт форми входу
class SignInFormState {
  final EmailInputValidation email;
  final PasswordInputValidation password;
  final bool isPasswordObscure;
  final bool isValid;

  const SignInFormState({
    this.email = const EmailInputValidation.pure(),
    this.password = const PasswordInputValidation.pure(),
    this.isPasswordObscure = true,
    this.isValid = false,
  });

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

  SignInFormState validate() {
    final valid = Formz.validate([email, password]);
    return copyWith(isValid: valid);
  }
}

/// 🧩 [SignInFormNotifier] — керує формою авторизації
class SignInFormNotifier extends StateNotifier<SignInFormState> {
  SignInFormNotifier() : super(const SignInFormState());

  void emailChanged(String value) {
    final email = EmailInputValidation.dirty(value);
    state = state.copyWith(email: email).validate();
  }

  void passwordChanged(String value) {
    final password = PasswordInputValidation.dirty(value);
    state = state.copyWith(password: password).validate();
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordObscure: !state.isPasswordObscure);
  }

  void reset() {
    state = const SignInFormState();
  }
}

/// 🪝 [signInFormProvider] — провайдер для [SignInFormNotifier]
final signInFormProvider =
    StateNotifierProvider.autoDispose<SignInFormNotifier, SignInFormState>(
      (ref) => SignInFormNotifier(),
    );
