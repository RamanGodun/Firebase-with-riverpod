import 'package:firebase_with_riverpod/core/utils_and_services/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/shared_presentation/constants/app_constants.dart';
import '../../../core/shared_modules/localization/app_strings.dart';
import '../../../core/shared_modules/navigation/routes_names.dart';
import '../../../core/utils_and_services/extensions/context_extensions/_context_extensions.dart';
import '../../../core/utils_and_services/snackbars.dart';
import '../../form_fields/form_field_widget.dart';
import '../../../core/shared_presentation/widgets/text_widget.dart';
import '../../../core/shared_presentation/widgets/buttons/custom_buttons.dart';
import '../../form_fields/form_fields_model.dart';
import '../../form_fields/form_state_provider.dart';
import '../../form_fields/presets_of_forms.dart';
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

    _listenToPasswordChange(context, ref);

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
                          ? AppStrings.submitting
                          : AppStrings.changePassword,
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
  void _listenToPasswordChange(BuildContext context, WidgetRef ref) {
    ref.listen(changePasswordProvider, (prev, next) async {
      next.whenOrNull(
        // error: (e, st) async {
        // final err = handleException(e);
        // if (err.code == 'requires-recent-login') {
        //   await _processRequiresRecentLogin(context, ref);
        // } else {
        // context.showErrorDialog(err);
        // }
        // },
        data: (_) {
          CustomSnackbars.show(
            ScaffoldMessenger.of(context),
            AppStrings.passwordUpdated,
          );
          context.goTo(RoutesNames.reAuthenticationPage);
        },
      );
    });
  }

  /// 🔐 Triggers the re-authentication flow if recent login is required
  // Future<void> _processRequiresRecentLogin(
  //   BuildContext context,
  //   WidgetRef ref,
  // ) async {
  //   final scaffoldMessenger = ScaffoldMessenger.of(context);

  //   final result = await context.pushTo<String>(const ReAuthenticationPage());

  //   if (result == 'success') {
  //     CustomSnackbars.show(scaffoldMessenger, AppStrings.reAuthSuccess);
  //     await ref.read(authRepositoryProvider).signout();
  //   }
  // }

  ///
}
