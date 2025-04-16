import 'package:firebase_with_riverpod/core/utils_and_services/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils_and_services/handle_exception.dart';
import '../input_forms/form_field_widget.dart';
import '../input_forms/form_fields_model.dart';
import '../../../features/input_forms/form_state_provider.dart';
import '../input_forms/presets_of_forms.dart';
import '../../presentation/widgets/buttons/custom_buttons.dart';
import '../../../presentation/widgets/text_widget.dart';
import '../../core/constants/app_constants.dart';
import '../../core/router/routes_names.dart';
import 'signin_provider.dart';
import '../../core/utils_and_services/extensions/context_extensions/_context_extensions.dart';

part 'widgets_for_signin_page.dart';

/// 🔐 [SignInPage] — screen that allows user to sign in.
class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldTypes = FormTemplates.signInFields;
    final formProvider = formStateNotifierProvider(fieldTypes);
    final formState = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);
    final isFormValid = ref.watch(formValidProvider(fieldTypes));
    final signInState = ref.watch(signinProvider);

    _listenToSignIn(context, ref);

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,
          child: Center(
            child: FocusTraversalGroup(
              child: Column(
                children: [
                  const _SigninHeader(),

                  for (final type in fieldTypes)
                    AppFormField(
                      type: type,
                      fields: fieldTypes,
                      showToggleVisibility: type == FormFieldType.password,
                    ),

                  const SizedBox(height: AppSpacing.xxl),

                  CustomButton(
                    type: ButtonType.filled,
                    label:
                        signInState.isLoading
                            ? AppStrings.submitting
                            : AppStrings.signInButton,
                    isEnabled: !signInState.isLoading,
                    isLoading: signInState.isLoading,
                    onPressed:
                        signInState.isLoading
                            ? null
                            : () => _handleSignIn(
                              ref,
                              formState,
                              formNotifier,
                              isFormValid,
                            ),
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

  /// 📩 Handles form validation and submission to [signinProvider].
  void _handleSignIn(
    WidgetRef ref,
    FormStateModel form,
    FormStateNotifier notifier,
    bool isFormValid,
  ) {
    if (isFormValid) {
      ref
          .read(signinProvider.notifier)
          .signin(
            email: form.valueOf(FormFieldType.email),
            password: form.valueOf(FormFieldType.password),
          );
    } else {
      notifier.validateAll();
    }
  }

  /// ⚠️ Subscribes to [signinProvider] and handles sign-in errors.
  void _listenToSignIn(BuildContext context, WidgetRef ref) {
    ref.listen(signinProvider, (prev, next) {
      next.whenOrNull(
        error: (e, _) => context.showErrorDialog(handleException(e)),
      );
    });
  }

  ///
}
