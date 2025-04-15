// ✅ Usage inside page with FocusTraversalGroup
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../input_forms/form_fields_models.dart';
import '../../../features/input_forms/form_state_provider.dart';
import '../../../features/input_forms/presets.dart';
import '../../../presentation/widgets/custom_button.dart';
import '../../../presentation/widgets/text_widget.dart';
import '../../core/constants/app_constants.dart';
import '../../core/router/routes_names.dart';
import '../../presentation/widgets/form_fields.dart';
import 'signin_provider.dart';
import '../../../core/utils_and_services/dialog_managing/error_dialog.dart';
import '../../../core/entities/custom_error.dart';
import '../../../core/utils_and_services/extensions/context_extensions.dart';

part 'widgets_for_signin_page.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fields = FormTemplates.signInFields;
    final formNotifierProviderInstance = formStateNotifierProvider(fields);
    final form = ref.watch(formNotifierProviderInstance);
    final isFormValid = ref.watch(formValidProvider(fields));
    final notifier = ref.read(formNotifierProviderInstance.notifier);
    final signin = ref.watch(signinProvider);

    ref.listen(signinProvider, (prev, next) {
      next.whenOrNull(
        error:
            (e, _) => ErrorHandling.showErrorDialog(context, e as CustomError),
      );
    });

    return GestureDetector(
      onTap: context.unfocusKeyboard,
      child: Scaffold(
        body: Center(
          child: FocusTraversalGroup(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                const _SigninHeader(),
                const SizedBox(height: 32),
                const TextWidget(
                  'Sign in to your account',
                  TextType.headlineSmall,
                ),
                const SizedBox(height: 32),
                for (final type in fields)
                  FormBuilderField(
                    // provider: formNotifierProviderInstance,
                    type: type,
                    showToggleVisibility: type == FormFieldType.password,
                  ),
                const SizedBox(height: 24),
                CustomButton(
                  type: ButtonType.filled,
                  onPressed:
                      signin.isLoading
                          ? null
                          : () {
                            if (isFormValid) {
                              _submit(ref, form);
                            } else {
                              notifier.validateAll();
                            }
                          },
                  label: signin.isLoading ? 'Submitting...' : 'Sign In',
                  isEnabled: !signin.isLoading,
                  isLoading: signin.isLoading,
                ),
                const SizedBox(height: AppSpacing.xl),

                const _SigninFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit(WidgetRef ref, FormStateModel form) {
    ref
        .read(signinProvider.notifier)
        .signin(
          email: form.valueOf(FormFieldType.email),
          password: form.valueOf(FormFieldType.password),
        );
  }
}
