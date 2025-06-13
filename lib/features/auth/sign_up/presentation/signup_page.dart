import 'package:firebase_with_riverpod/core/general_utils/widget_ref_extensions/show_dialog_when_error_x.dart';
import 'package:firebase_with_riverpod/core/shared_modules/navigation/utils/context_x.dart';
import 'package:firebase_with_riverpod/core/shared_layers/shared_presentation/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/shared_modules/localization/code_base_for_both_options/text_widget.dart';
import '../../../../core/shared_modules/localization/generated/locale_keys.g.dart';
import '../../../../core/shared_modules/theme/core/constants/_app_constants.dart';
import '../../../../core/shared_modules/navigation/routes_names.dart';
import '../../../../core/shared_layers/shared_presentation/extensions/context_extensions/_context_extensions.dart';
import '../../../../core/shared_layers/shared_presentation/widgets/buttons/custom_buttons.dart';
import '../../../form_fields/form_field_widget.dart';
import '../../../form_fields/form_fields_model.dart';
import '../../../form_fields/form_state_provider.dart';
import '../../../form_fields/presets_of_forms.dart';
import 'signup_provider.dart';

part 'widgets_for_signup_page.dart';

/// 🔐 [SignupPage] — screen that allows user to register a new account.

class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});
  //---------------------------

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

                CustomButton(
                  type: ButtonType.filled,
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
