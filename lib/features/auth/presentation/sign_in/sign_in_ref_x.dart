import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/_signin_provider.dart';
import 'providers/sign_in_form_fields_provider.dart';

/// 📩 Handles form validation and submission to [signinProvider].
extension SignInSubmitX on WidgetRef {
  ///-------------------------------
  //
  /// 📩 Triggers sign-in logic based on current form state
  void submitSignIn() {
    final form = read(signInFormProvider);
    read(
      signInProvider.notifier,
    ).signin(email: form.email.value, password: form.password.value);
  }
}
