import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_riverpod/core/modules_shared/localization/generated/locale_keys.g.dart';
import 'package:firebase_with_riverpod/core/utils_shared/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_riverpod/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:firebase_with_riverpod/features/auth/utils_for_auth_feature/change_password_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../form_fields/form_field_widget.dart';
import '../../../form_fields/form_fields_model.dart';
import '../../../form_fields/form_state_provider.dart';
import '../../../form_fields/presets_of_forms.dart';
import '../../../../core/modules_shared/localization/widgets/text_widget.dart';
import '../../../../core/modules_shared/theme/theme_styling/main_constants/_app_constants.dart';
import '../../../../core/layers_shared/presentation_layer_shared/widgets_shared/buttons/custom_buttons.dart';
import 'change_password_provider.dart';

part 'widgets_for_change_password.dart';

/// 🔐 [ChangePasswordPage] — Screen that allows the user to update their password.

class ChangePasswordPage extends ConsumerWidget {
  ///-------------------------------------------
  const ChangePasswordPage({super.key});
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final fieldTypes = FormTemplates.changePasswordFields;
    final formProvider = formStateNotifierProvider(fieldTypes);
    final formState = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);
    final isFormValid = ref.watch(formValidProvider(fieldTypes));

    final changePasswordState = ref.watch(changePasswordProvider);

    // 🔁 Declarative side-effect for ChangePassword
    ref.listenToPasswordChange(context);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,
          child: FocusTraversalGroup(
            child: ListView(
              shrinkWrap: true,
              children: [
                const _ChangePasswordInfo(),
                const SizedBox(height: AppSpacing.xxxm),
                for (final type in fieldTypes)
                  AppFormField(
                    type: type,
                    fields: fieldTypes,
                    showToggleVisibility: true,
                  ),
                const SizedBox(height: AppSpacing.massive),
                CustomButton(
                  type: ButtonType.filled,
                  onPressed:
                      changePasswordState.isLoading
                          ? null
                          : () {
                            if (isFormValid) {
                              ref
                                  .read(changePasswordProvider.notifier)
                                  .changePassword(
                                    formState.valueOf(FormFieldType.password),
                                  );
                            } else {
                              formNotifier.validateAll();
                            }
                          },
                  label:
                      changePasswordState.isLoading
                          ? LocaleKeys.buttons_submitting
                          : LocaleKeys.change_password_title,
                  isEnabled: !changePasswordState.isLoading,
                  isLoading: changePasswordState.isLoading,
                ),
                const SizedBox(height: AppSpacing.huge),
              ],
            ).withPaddingHorizontal(AppSpacing.l),
          ),
        ),
      ),
    );
  }

  //
}
