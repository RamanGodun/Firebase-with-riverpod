part of '_signup_page.dart';

/// 🧩 [_NameInputField] — name input field
class _NameInputField extends ConsumerWidget {
  final ({
    FocusNode name,
    FocusNode email,
    FocusNode password,
    FocusNode confirmPassword,
  })
  focus;
  const _NameInputField(this.focus);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(signUpFormProvider);
    final formNotifier = ref.read(signUpFormProvider.notifier);

    return InputFieldFactory.create(
      type: InputFieldType.name,
      focusNode: focus.name,
      errorText: form.name.uiErrorKey,
      onChanged: formNotifier.nameChanged,
      onSubmitted: () => focus.email.requestFocus(),
    );
  }
}

/// 🧩 [_EmailInputField] — email input field
class _EmailInputField extends ConsumerWidget {
  final ({
    FocusNode name,
    FocusNode email,
    FocusNode password,
    FocusNode confirmPassword,
  })
  focus;
  const _EmailInputField(this.focus);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(signUpFormProvider);
    final formNotifier = ref.read(signUpFormProvider.notifier);

    return InputFieldFactory.create(
      type: InputFieldType.email,
      focusNode: focus.email,
      errorText: form.email.uiErrorKey,
      onChanged: formNotifier.emailChanged,
      onSubmitted: () => focus.password.requestFocus(),
    );
  }
}

/// 🧩 [_PasswordInputField] — password input field
class _PasswordInputField extends ConsumerWidget {
  final ({
    FocusNode name,
    FocusNode email,
    FocusNode password,
    FocusNode confirmPassword,
  })
  focus;
  const _PasswordInputField(this.focus);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(signUpFormProvider);
    final formNotifier = ref.read(signUpFormProvider.notifier);

    return InputFieldFactory.create(
      type: InputFieldType.password,
      focusNode: focus.password,
      errorText: form.password.uiErrorKey,
      isObscure: form.isPasswordObscure,
      onChanged: formNotifier.passwordChanged,
      onSubmitted: () => focus.confirmPassword.requestFocus(),
      suffixIcon: ObscureToggleIcon(
        isObscure: form.isPasswordObscure,
        onPressed: formNotifier.togglePasswordVisibility,
      ),
    );
  }
}

/// 🧩 [_ConfirmPasswordInputField] — confirm password field
class _ConfirmPasswordInputField extends ConsumerWidget {
  final ({
    FocusNode name,
    FocusNode email,
    FocusNode password,
    FocusNode confirmPassword,
  })
  focus;
  const _ConfirmPasswordInputField(this.focus);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(signUpFormProvider);
    final formNotifier = ref.read(signUpFormProvider.notifier);

    return InputFieldFactory.create(
      type: InputFieldType.confirmPassword,
      focusNode: focus.confirmPassword,
      errorText: form.confirmPassword.uiErrorKey,
      isObscure: form.isConfirmPasswordObscure,
      onChanged: formNotifier.confirmPasswordChanged,
      onSubmitted: form.isValid ? () => ref.submitSignUp() : null,
      suffixIcon: ObscureToggleIcon(
        isObscure: form.isConfirmPasswordObscure,
        onPressed: formNotifier.toggleConfirmPasswordVisibility,
      ),
    );
  }
}
