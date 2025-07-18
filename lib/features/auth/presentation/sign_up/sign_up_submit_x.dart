import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/sign_up_form_provider.dart';
import 'providers/sign_up_provider.dart';

/// 📩 Handles form validation and submission to [signupProvider].
//
extension SignUpRefX on WidgetRef {
  ///-------------------------------
  //
  /// 📩 Triggers sign-up logic based on current form state
  void submit() {
    final form = read(signUpFormProvider);
    read(signupProvider.notifier).signup(
      name: form.name.value,
      email: form.email.value,
      password: form.password.value,
    );
  }

  //
}
