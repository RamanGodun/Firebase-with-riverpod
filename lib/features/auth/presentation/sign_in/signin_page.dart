import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/utils/for_riverpod/extensions/show_dialog_when_error_x.dart';
import 'package:firebase_with_riverpod/core/shared_modules/navigation/utils/context_x.dart';
import 'package:firebase_with_riverpod/core/shared_layers/shared_presentation/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/shared_modules/theme/core/app_colors.dart';
import '../../../form_fields/form_field_widget.dart';
import '../../../form_fields/form_fields_model.dart';
import '../../../form_fields/form_state_provider.dart';
import '../../../form_fields/presets_of_forms.dart';
import '../../../../core/shared_modules/localization/code_base_for_both_options/text_widget.dart';
import '../../../../core/shared_modules/localization/generated/locale_keys.g.dart';
import '../../../../core/shared_layers/shared_presentation/widgets/buttons/custom_buttons.dart';
import '../../../../core/shared_layers/shared_presentation/constants/_app_constants.dart';
import '../../../../core/shared_modules/navigation/routes_names.dart';
import 'signin_provider.dart';
import '../../../../core/shared_layers/shared_presentation/extensions/context_extensions/_context_extensions.dart';

part 'widgets_for_signin_page.dart';

/// 🔐 [SignInPage] — screen that allows user to sign in.
class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //

    final fieldTypes = FormTemplates.signInFields;
    final formProvider = formStateNotifierProvider(fieldTypes);
    final formState = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);
    final isFormValid = ref.watch(formValidProvider(fieldTypes));
    final signInState = ref.watch(signInProvider);

    // 🔁 Declarative side-effect for error displaying
    ref.listenFailure(signInProvider, context);

    /// used "LayoutBuilder + ConstrainedBox + IntrinsicHeight" pattern
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: FocusTraversalGroup(
                  child: ListView(
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
                                ? LocaleKeys.buttons_submitting
                                : LocaleKeys.buttons_sign_in,
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
              );
            },
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
          .read(signInProvider.notifier)
          .signin(
            email: form.valueOf(FormFieldType.email),
            password: form.valueOf(FormFieldType.password),
          );
    } else {
      notifier.validateAll();
    }
  }

  //
}
