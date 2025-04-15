import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/entities/custom_error.dart';
import '../../core/router/routes_names.dart';
import '../../core/utils_and_services/dialog_managing/error_dialog.dart';
import '../../core/utils_and_services/extensions/context_extensions.dart';
import '../../presentation/widgets/buttons/custom_buttons.dart';
import '../../presentation/widgets/text_widget.dart';
import '../input_forms/form_field_widget.dart';
import '../input_forms/form_fields_model.dart';
import '../../../features/input_forms/form_state_provider.dart';
import '../input_forms/presets_of_forms.dart';
import 'signup_provider.dart';

part 'widgets_for_signup_page.dart';

class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fields = FormTemplates.signUpFields;
    final provider = formStateNotifierProvider(fields);
    final form = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    final isFormValid = ref.watch(formValidProvider(fields));
    final signupState = ref.watch(signupProvider);

    _listenForSignupErrors(context, ref);

    return GestureDetector(
      onTap: context.unfocusKeyboard,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
            child: ListView(
              shrinkWrap: true,
              children: [
                const _SignupHeader(),
                const SizedBox(height: AppSpacing.l),
                for (final type in fields)
                  AppFormField(
                    type: type,
                    fields: fields,
                    showToggleVisibility:
                        type == FormFieldType.password ||
                        type == FormFieldType.confirmPassword,
                  ),
                const SizedBox(height: AppSpacing.l),
                CustomButton(
                  type: ButtonType.filled,
                  onPressed:
                      signupState.isLoading
                          ? null
                          : () {
                            if (isFormValid) {
                              ref
                                  .read(signupProvider.notifier)
                                  .signup(
                                    name: form.valueOf(FormFieldType.name),
                                    email: form.valueOf(FormFieldType.email),
                                    password: form.valueOf(
                                      FormFieldType.password,
                                    ),
                                  );
                            } else {
                              notifier.validateAll();
                            }
                          },
                  label: signupState.isLoading ? 'Submitting...' : 'Sign Up',
                  isEnabled: !signupState.isLoading,
                  isLoading: signupState.isLoading,
                ),
                const SizedBox(height: AppSpacing.xl),
                const _SignupFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  void _listenForSignupErrors(BuildContext context, WidgetRef ref) {
    ref.listen(signupProvider, (prev, next) {
      next.whenOrNull(
        error:
            (e, _) => ErrorHandling.showErrorDialog(context, e as CustomError),
      );
    });
  }

  ///
}
