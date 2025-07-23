
/// 🔐 [SignUpPage] — screen that allows user to register a new account.

class SignUpPage extends ConsumerWidget {
  ///-----------------------------------
  const SignUpPage({super.key});
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final fieldTypes = FormTemplates.signUpFields;
    final formProvider = formStateNotifierProvider(fieldTypes);
    final formState = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);
    final isFormValid = ref.watch(formValidProvider(fieldTypes));
    final signUpState = ref.watch(signupProvider);

    // ❗️ Declarative error handling
    ref.listenFailure(signupProvider, context);

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,
          child: FocusTraversalGroup(
            child: ListView(
              shrinkWrap: true,
              children: [
                const _SignupHeader(),

                for (final type in fieldTypes)
                  AppFormField(
                    type: type,
                    fields: fieldTypes,
                    showToggleVisibility:
                        type == FormFieldType.password ||
                        type == FormFieldType.confirmPassword,
                  ),

                const SizedBox(height: AppSpacing.xxl),

                CustomFilledButton(
                  label:
                      signUpState.isLoading
                          ? LocaleKeys.buttons_submitting
                          : LocaleKeys.buttons_sign_up,
                  isEnabled: !signUpState.isLoading,
                  isLoading: signUpState.isLoading,
                  onPressed:
                      signUpState.isLoading
                          ? null
                          : () => _handleSignup(
                            ref,
                            formState,
                            formNotifier,
                            isFormValid,
                          ),
                ),

                const SizedBox(height: AppSpacing.xl),
                const _SignupFooter(),
              ],
            ).withPaddingHorizontal(AppSpacing.xxxm),
          ),
        ),
      ),
    );
  }

  /// 📩 Handles signup logic via [signupProvider]
  void _handleSignup(
    WidgetRef ref,
    FormStateModel form,
    FormStateNotifier notifier,
    bool isFormValid,
  ) {
    if (isFormValid) {
      ref
          .read(signupProvider.notifier)
          .signup(
            name: form.valueOf(FormFieldType.name),
            email: form.valueOf(FormFieldType.email),
            password: form.valueOf(FormFieldType.password),
          );
    } else {
      notifier.validateAll();
    }
  }

  //
}