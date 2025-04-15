import 'package:firebase_with_riverpod/core/utils_and_services/extensions/others.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/entities/custom_error.dart';
import '../../core/utils_and_services/extensions/context_extensions.dart';
import '../../core/utils_and_services/dialog_managing/error_dialog.dart';
import '../../core/utils_and_services/snackbars.dart';
import '../../data/repositories/auth/auth_repository_provider.dart';
import '../input_forms/form_field_widget.dart';
import '../user_validation/reauthenticate_page.dart';
import '../../presentation/widgets/text_widget.dart';
import '../../presentation/widgets/buttons/custom_buttons.dart';
import '../../features/input_forms/form_fields_models.dart';
import '../../features/input_forms/form_state_provider.dart';
import '../../features/input_forms/form_presets.dart';
import 'change_password_provider.dart';

part 'widgets_for_change_password.dart';

/// 🔐 [ChangePasswordPage] — Screen that allows the user to update their password.
class ChangePasswordPage extends ConsumerWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fields = FormTemplates.changePasswordFields;
    final provider = formStateNotifierProvider(fields);
    final form = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    final isFormValid = ref.watch(formValidProvider(fields));
    final state = ref.watch(changePasswordProvider);

    _listenToPasswordChange(context, ref);

    return GestureDetector(
      onTap: context.unfocusKeyboard,
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              const _ChangePasswordInfo(),
              const SizedBox(height: AppSpacing.m),
              for (final type in fields)
                AppFormField(
                  type: type,
                  fields: fields,
                  showToggleVisibility: true,
                ),
              const SizedBox(height: AppSpacing.xxl),
              CustomButton(
                type: ButtonType.filled,
                onPressed:
                    state.isLoading
                        ? null
                        : () {
                          if (isFormValid) {
                            ref
                                .read(changePasswordProvider.notifier)
                                .changePassword(
                                  form.valueOf(FormFieldType.password),
                                );
                          } else {
                            notifier.validateAll();
                          }
                        },
                label:
                    state.isLoading
                        ? AppStrings.submitting
                        : AppStrings.changePassword,
                isEnabled: !state.isLoading,
                isLoading: state.isLoading,
              ),
              const SizedBox(height: AppSpacing.huge),
            ],
          ).withPaddingHorizontal(AppSpacing.l),
        ),
      ),
    );
  }

  /// 🔁 Listens for state changes in [changePasswordProvider] to trigger error dialogs or success actions.
  void _listenToPasswordChange(BuildContext context, WidgetRef ref) {
    ref.listen(changePasswordProvider, (prev, next) async {
      next.whenOrNull(
        error: (e, st) {
          final err = e as CustomError;
          if (err.code == 'requires-recent-login') {
            _processRequiresRecentLogin(context);
          } else {
            ErrorHandling.showErrorDialog(context, err);
          }
        },
        data: (_) async {
          await ref.read(authRepositoryProvider).signout();
        },
      );
    });
  }

  /// 🔐 Triggers the re-authentication flow if recent login is required
  Future<void> _processRequiresRecentLogin(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final result = await context.pushTo<String>(const ReAuthenticationPage());
    if (result == 'success')
      CustomSnackbars.show(scaffoldMessenger, AppStrings.reAuthSuccess);
  }
}
