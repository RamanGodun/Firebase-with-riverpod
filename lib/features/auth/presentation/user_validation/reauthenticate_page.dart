import 'package:firebase_with_riverpod/core/shared_modules/localization/generated/locale_keys.g.dart'
    show LocaleKeys;
import 'package:firebase_with_riverpod/core/shared_modules/navigation/utils/context_x.dart';
import 'package:firebase_with_riverpod/core/utils/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/shared_modules/localization/code_base_for_both_options/text_widget.dart';
import '../../../../core/shared_presentation/constants/_app_constants.dart';
import '../../../../core/shared_modules/navigation/routes_names.dart';
import '../../../../core/utils/extensions/context_extensions/_context_extensions.dart';
import '../../../../core/shared_modules/form_fields/form_field_widget.dart';
import '../../../../core/shared_modules/form_fields/form_fields_model.dart';
import '../../../../core/shared_modules/form_fields/form_state_provider.dart';
import '../../../../core/shared_modules/form_fields/presets_of_forms.dart';
import '../../../../core/shared_presentation/widgets/buttons/custom_buttons.dart';
import '../sign_out/sign_out_buttons.dart';

/// 🔐 [ReAuthenticationPage] — screen used to re-authenticate the user before sensitive operations
class ReAuthenticationPage extends ConsumerWidget {
  const ReAuthenticationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldTypes = FormTemplates.reAuthenticationFields;
    final formProvider = formStateNotifierProvider(fieldTypes);
    final formState = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);
    final isFormValid = ref.watch(formValidProvider(fieldTypes));
    final submitting = ValueNotifier(false);

    return Scaffold(
      appBar: AppBar(),
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
}

/// ℹ️ [_ReauthenticateInfo] — informative section about re-authentication requirement
class _ReauthenticateInfo extends StatelessWidget {
  const _ReauthenticateInfo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: AppSpacing.massive),
        TextWidget(LocaleKeys.reauth_label, TextType.headlineMedium),
        TextWidget(
          LocaleKeys.reauth_description,
          TextType.titleSmall,
          isTextOnFewStrings: true,
        ),
        SizedBox(height: AppSpacing.xl),
      ],
    );
  }
}

/// 🔁 [_ReAuthFooter] — sign in redirect
class _ReAuthFooter extends ConsumerWidget {
  const _ReAuthFooter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        SizedBox(height: AppSpacing.xl),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextWidget(LocaleKeys.reauth_redirect_note, TextType.titleSmall),
            SignOutButton(),
            // CustomButton(
            //   type: ButtonType.text,
            //   onPressed: () async {
            //     await ref.read(signOutProvider.notifier).signOut();
            //   },
            //   label: AppStrings.signInButton,
            //   fontWeight: FontWeight.w600,
            //   fontSize: 15,
            //   isEnabled: true,
            //   isLoading: false,
            // ),
            TextWidget(LocaleKeys.reauth_page, TextType.titleSmall),
          ],
        ),
      ],
    );
  }
}
