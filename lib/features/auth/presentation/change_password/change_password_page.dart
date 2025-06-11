import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_riverpod/core/shared_modules/localization/generated/locale_keys.g.dart';
import 'package:firebase_with_riverpod/core/shared_modules/navigation/utils/context_x.dart';
import 'package:firebase_with_riverpod/core/shared_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:firebase_with_riverpod/core/shared_layers/shared_presentation/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_riverpod/core/shared_layers/shared_presentation/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_with_riverpod/features/auth/presentation/sign_out/sign_out_provider.dart';
import '../../../../core/shared_modules/errors_handling/old_and_simple/fb_exceptions.dart';
import '../../../../core/utils/typedef.dart';
import '../../../form_fields/form_field_widget.dart';
import '../../../form_fields/form_fields_model.dart';
import '../../../form_fields/form_state_provider.dart';
import '../../../form_fields/presets_of_forms.dart';
import '../../../../core/shared_modules/localization/code_base_for_both_options/text_widget.dart';
import '../../../../core/shared_modules/navigation/routes_names.dart';
import '../../../../core/shared_layers/shared_presentation/constants/_app_constants.dart';
import '../../../../core/shared_layers/shared_presentation/widgets/buttons/custom_buttons.dart';
import '../user_validation/reauthenticate_page.dart';
import 'change_password_provider.dart';

part 'widgets_for_change_password.dart';

/// 🔐 [ChangePasswordPage] — Screen that allows the user to update their password.
class ChangePasswordPage extends ConsumerWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldTypes = FormTemplates.changePasswordFields;
    final formProvider = formStateNotifierProvider(fieldTypes);
    final formState = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);
    final isFormValid = ref.watch(formValidProvider(fieldTypes));
    final changePasswordState = ref.watch(changePasswordProvider);

    final showSnackbar = context.showUserSnackbar;
    final goTo = context.goTo;

    _listenToPasswordChange(ref, context, showSnackbar, goTo);

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
                const SizedBox(height: AppSpacing.m),
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

  /// 🔁 Listens for state changes in [changePasswordProvider] to trigger error dialogs or success actions.
  void _listenToPasswordChange(
    WidgetRef ref,
    BuildContext context,
    ShowUserSnackbar showSnackbar,
    GoTo goTo,
  ) {
    //
    ref.listen(changePasswordProvider, (prev, next) async {
      next.whenOrNull(
        data: (_) {
          showSnackbar(message: LocaleKeys.reauth_password_updated.tr());
          if (context.mounted) goTo(RoutesNames.reAuthenticationPage);
        },
        //
        error: (e, st) async {
          final error = handleException(e);
          if (error.code == 'requires-recent-login') {
            await _processRequiresRecentLogin(context, showSnackbar, ref);
          } else {
            // TODO: showErrorDialog(error);
          }
        },
      );
    });
  }

  /// 🔐 Triggers the re-authentication flow if recent login is required
  Future<void> _processRequiresRecentLogin(
    BuildContext context,
    ShowUserSnackbar showSnackbar,
    WidgetRef ref,
  ) async {
    final result = await context.pushTo<String>(const ReAuthenticationPage());

    if (result == 'success') {
      showSnackbar(message: LocaleKeys.change_password_success.tr());
      await ref.read(signOutProvider.notifier).signOut();
    }
  }

  ///
}
