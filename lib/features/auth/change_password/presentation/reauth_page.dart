import 'package:firebase_with_riverpod/core/shared_modules/localization/generated/locale_keys.g.dart'
    show LocaleKeys;
import 'package:firebase_with_riverpod/core/shared_modules/navigation/utils/context_x.dart';
import 'package:firebase_with_riverpod/core/shared_layers/shared_presentation/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/shared_modules/localization/code_base_for_both_options/text_widget.dart';
import '../../../../core/shared_modules/theme/core/constants/_app_constants.dart';
import '../../../../core/shared_modules/navigation/routes_names.dart';
import '../../../../core/shared_layers/shared_presentation/extensions/context_extensions/_context_extensions.dart';
import '../../../form_fields/form_field_widget.dart';
import '../../../form_fields/form_fields_model.dart';
import '../../../form_fields/form_state_provider.dart';
import '../../../form_fields/presets_of_forms.dart';
import '../../../../core/shared_layers/shared_presentation/widgets/buttons/custom_buttons.dart';
import '../../sign_out/presentation/sign_out_buttons.dart';

part 'widgets_for_reauth_page.dart';

/// 🔐 [ReAuthenticationPage] — screen used to re-authenticate the user before sensitive operations

class ReAuthenticationPage extends ConsumerWidget {
  const ReAuthenticationPage({super.key});
  //------------------------------------

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final fieldTypes = FormTemplates.reAuthenticationFields;
    final formProvider = formStateNotifierProvider(fieldTypes);
    final formState = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);
    final isFormValid = ref.watch(formValidProvider(fieldTypes));
    final submitting = ValueNotifier(false);

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,
          child: FocusTraversalGroup(
            child: ValueListenableBuilder<bool>(
              valueListenable: submitting,
              builder:
                  (context, isSubmitting, _) => ListView(
                    shrinkWrap: true,
                    children: [
                      const _ReauthenticateInfo(),

                      for (final type in fieldTypes)
                        AppFormField(
                          type: type,
                          fields: fieldTypes,
                          showToggleVisibility: type == FormFieldType.password,
                        ),
                      const SizedBox(height: AppSpacing.huge),

                      CustomButton(
                        type: ButtonType.filled,
                        label:
                            isSubmitting
                                ? LocaleKeys.buttons_submitting
                                : LocaleKeys.pages_reauthentication,
                        isEnabled: !isSubmitting,
                        isLoading: isSubmitting,
                        onPressed:
                            isSubmitting
                                ? null
                                : () => _handleSubmit(
                                  context,
                                  formState,
                                  isFormValid,
                                  formNotifier,
                                  submitting,
                                ),
                      ),
                      const _ReAuthFooter(),
                    ],
                  ),
            ).withPaddingHorizontal(AppSpacing.l),
          ),
        ),
      ),
    );
  }

  /// ✅ Handles validation & simulates reauthentication submission
  void _handleSubmit(
    BuildContext context,
    FormStateModel form,
    bool isFormValid,
    FormStateNotifier notifier,
    ValueNotifier<bool> submitting,
  ) {
    if (!isFormValid) {
      notifier.validateAll();
      return;
    }
    submitting.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      if (!context.mounted) return;
      submitting.value = false;
      context.goTo(RoutesNames.home);
    });
  }

  //
}
