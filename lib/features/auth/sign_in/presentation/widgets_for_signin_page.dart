part of 'signin_page.dart';

/// 🧩 [_SignInEmailInputField] — email and password fields

class _SignInEmailInputField extends ConsumerWidget {
  ///-----------------------------------------------

  final ({FocusNode email, FocusNode password}) focus;
  const _SignInEmailInputField(this.focus);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(signInFormProvider);
    final formNotifier = ref.read(signInFormProvider.notifier);

    return InputFieldFactory.create(
      type: InputFieldType.email,
      focusNode: focus.email,
      errorText: form.email.uiErrorKey,
      onChanged: formNotifier.emailChanged,
      onSubmitted: () => focus.password.requestFocus(),
    );
  }
}

////

////

/// 🧩 [_SignInPasswordInputField] — password input field with visibility toggle

class _SignInPasswordInputField extends ConsumerWidget {
  ///-------------------------------------------------

  final ({FocusNode email, FocusNode password}) focus;
  const _SignInPasswordInputField(this.focus);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(signInFormProvider);
    final formNotifier = ref.read(signInFormProvider.notifier);

    return InputFieldFactory.create(
      type: InputFieldType.password,
      focusNode: focus.password,
      errorText: form.password.uiErrorKey,
      isObscure: form.isPasswordObscure,
      onChanged: formNotifier.passwordChanged,
      onSubmitted: () => ref.submitSignIn(),
      suffixIcon: ObscureToggleIcon(
        isObscure: form.isPasswordObscure,
        onPressed: formNotifier.togglePasswordVisibility,
      ),
    );
  }
}

////

////

/// 🔘 [_SigninSubmitButton] — submit button for the sign-in form
class _SigninSubmitButton extends ConsumerWidget {
  ///-------------------------------------------
  const _SigninSubmitButton();
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(signInFormProvider);
    final signInState = ref.watch(signInProvider);
    final isOverlayActive = ref.isOverlayActive;

    return CustomFilledButton(
      label:
          signInState.isLoading
              ? LocaleKeys.buttons_submitting
              : LocaleKeys.buttons_sign_in,
      isEnabled: form.isValid && !isOverlayActive,
      isLoading: signInState.isLoading,
      onPressed:
          form.isValid && !signInState.isLoading
              ? () => ref.submitSignIn()
              : null,
    );
  }
}

////

////

/// 🔁 [_SigninFooter] — sign up & reset password actions

class _SigninFooter extends StatelessWidget {
  ///---------------------------------------
  const _SigninFooter();
  //

  @override
  Widget build(BuildContext context) {
    //
    return Column(
      children: [
        //
        const TextWidget(
          LocaleKeys.buttons_redirect_to_sign_up,
          TextType.bodyMedium,
        ),
        const SizedBox(width: AppSpacing.s),

        AppTextButton(
          onPressed: () => context.goTo(RoutesNames.signUp),
          label: LocaleKeys.buttons_sign_up,
        ),
        const SizedBox(height: AppSpacing.xl),

        AppTextButton(
          onPressed: () => context.goTo(RoutesNames.resetPassword),
          label: LocaleKeys.sign_in_forgot_password,
          foregroundColor: AppColors.forErrors,
        ),
      ],
    );
  }
}
