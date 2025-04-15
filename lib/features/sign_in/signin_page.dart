import 'package:firebase_with_riverpod/core/utils_and_services/extensions/others.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../input_forms/form_fields_models.dart';
import '../../../features/input_forms/form_state_provider.dart';
import '../input_forms/form_presets.dart';
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
    final provider = formStateNotifierProvider(fields);
    final form = ref.watch(provider);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    final isFormValid = ref.watch(formValidProvider(fields));
    final signin = ref.watch(signinProvider);

    _listenForErrors(context, ref);

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,
          child: Center(
            child: FocusTraversalGroup(
              child: Column(
                spacing: AppSpacing.s,
                children: [
                  const _SigninHeader(),
                  const SizedBox(height: AppSpacing.l),
                  const TextWidget(
                    'Sign in to your account',
                    TextType.headlineSmall,
                  ),
                  const SizedBox(height: AppSpacing.s),

                  for (final type in fields)
                    FormBuilderField(
                      state: state,
                      notifier: notifier,
                      type: type,
                      showToggleVisibility: type == FormFieldType.password,
                    ),
                  const SizedBox(height: AppSpacing.xxl),

                  CustomButton(
                    type: ButtonType.filled,
                    label: signin.isLoading ? 'Submitting...' : 'Sign In',
                    isEnabled: !signin.isLoading,
                    isLoading: signin.isLoading,
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
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  const _SigninFooter(),
                ],
              ).withPaddingHorizontal(AppSpacing.m),
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

  void _listenForErrors(BuildContext context, WidgetRef ref) {
    ref.listen(signinProvider, (prev, next) {
      next.whenOrNull(
        error:
            (e, _) => ErrorHandling.showErrorDialog(context, e as CustomError),
      );
    });
  }

  ///
}
