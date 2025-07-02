import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../sign_up/presentation/providers/sign_up_form_provider.dart';
import '../sign_up/presentation/providers/signup_provider.dart';

/// 📩 Handles form validation and submission to [signupProvider].
extension SignUpSubmitX on WidgetRef {
  ///-------------------------------

  /// 📩 Triggers sign-up logic based on current form state
  void submitSignUp() {
    final form = read(signUpFormProvider);

    read(signupProvider.notifier).signup(
      name: form.name.value,
      email: form.email.value,
      password: form.password.value,
    );
  }

  //
}
