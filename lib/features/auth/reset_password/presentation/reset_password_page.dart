import 'package:firebase_with_riverpod/core/modules_shared/localization/generated/locale_keys.g.dart'
    show LocaleKeys;
import 'package:firebase_with_riverpod/core/modules_shared/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_riverpod/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:firebase_with_riverpod/features/auth/utils_for_auth_feature/reset_password_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/modules_shared/localization/widgets/text_widget.dart';
import '../../../../core/modules_shared/navigation/app_routes/app_routes.dart';
import '../../../../core/modules_shared/theme/ui_constants/_app_constants.dart';
import '../../../../core/utils_shared/extensions/context_extensions/_context_extensions.dart';
import '../../../../core/layers_shared/presentation_layer_shared/widgets_shared/buttons/custom_buttons.dart';
import '../../../form_fields_old/form_field_widget.dart';
import '../../../form_fields_old/form_fields_model.dart';
import '../../../form_fields_old/form_state_provider.dart';
import '../../../form_fields_old/presets_of_forms.dart';
import 'reset_password_provider.dart';

part 'widgets_for_reset_password_page.dart';

/// 🔐 [ResetPasswordPage] — screen that allows user to request password reset
/// 📩 Sends reset link to user's email using [ResetPasswordProvider]
/// 🧼 Declarative Riverpod + FormState + centralized error handling

class ResetPasswordPage extends ConsumerWidget {
  ///------------------------------------------
  const ResetPasswordPage({super.key});
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 🎯 Reactive form state management
    final fieldTypes = FormTemplates.resetPasswordFields;
    final formProvider = formStateNotifierProvider(fieldTypes);
    final formState = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);
    final isFormValid = ref.watch(formValidProvider(fieldTypes));

    // 🔁 Async state of the reset password request
    final resetPasswordState = ref.watch(resetPasswordProvider);

    // 👂 Declarative listener for success/failure
    ref.listenToResetPassword(context);

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,
          child: FocusTraversalGroup(
            child: ListView(
              shrinkWrap: true,
              children: [
                //
                const _ResetPasswordHeader(),

                /// 🧾 Dynamic fields from form preset
                for (final type in fieldTypes)
                  AppFormField(type: type, fields: fieldTypes),
                const SizedBox(height: AppSpacing.huge),

                /// 🔘 Submit button — disabled while loading
                CustomButton(
                  type: ButtonType.filled,
                  onPressed:
                      resetPasswordState.isLoading
                          ? null
                          : () => _handleResetPressed(
                            ref,
                            formState,
                            formNotifier,
                            isFormValid,
                          ),
                  label:
                      resetPasswordState.isLoading
                          ? LocaleKeys.buttons_submitting
                          : LocaleKeys.buttons_reset_password,
                  isLoading: resetPasswordState.isLoading,
                  isEnabled: !resetPasswordState.isLoading,
                ),
                const SizedBox(height: AppSpacing.xxxs),
                const _ResetPasswordFooter(),
              ],
            ).withPaddingHorizontal(AppSpacing.l),
          ),
        ),
      ),
    );
  }

  /// 🧩 [_handleResetPressed] — validates form and sends reset email
  /// If form is valid, calls `resetPassword()`; otherwise, forces validation
  void _handleResetPressed(
    WidgetRef ref,
    FormStateModel form,
    FormStateNotifier notifier,
    bool isFormValid,
  ) {
    if (isFormValid) {
      ref
          .read(resetPasswordProvider.notifier)
          .resetPassword(email: form.valueOf(FormFieldType.email));
    } else {
      notifier.validateAll();
    }
  }

  //
}
