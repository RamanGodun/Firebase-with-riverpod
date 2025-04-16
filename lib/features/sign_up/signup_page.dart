import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/router/routes_names.dart';
import '../../core/utils_and_services/handle_exception.dart';
import '../../core/utils_and_services/extensions/context_extensions/_context_extensions.dart';
import '../../presentation/widgets/buttons/custom_buttons.dart';
import '../../presentation/widgets/text_widget.dart';
import '../input_forms/form_field_widget.dart';
import '../input_forms/form_fields_model.dart';
import '../../../features/input_forms/form_state_provider.dart';
import '../input_forms/presets_of_forms.dart';
import 'signup_provider.dart';

part 'widgets_for_signup_page.dart';

/// 🔐 [SignupPage] — screen that allows user to register a new account.
class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldTypes = FormTemplates.signUpFields;
    final formProvider = formStateNotifierProvider(fieldTypes);
    final formState = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);
    final isFormValid = ref.watch(formValidProvider(fieldTypes));
    final signUpState = ref.watch(signupProvider);

    _listenToSignup(context, ref);

    return GestureDetector(
      onTap: context.unfocusKeyboard,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
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

                  CustomButton(
                    type: ButtonType.filled,
                    label:
                        signUpState.isLoading
                            ? AppStrings.submitting
                            : AppStrings.signUpButton,
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
              ),
            ),
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

  /// ⚠️ Subscribes to [signupProvider] and handles errors
  void _listenToSignup(BuildContext context, WidgetRef ref) {
    ref.listen(signupProvider, (prev, next) {
      next.whenOrNull(
        error: (e, _) => context.showErrorDialog(handleException(e)),
      );
    });
  }

  ///
}
