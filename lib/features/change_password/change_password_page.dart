import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/entities/custom_error.dart';
import '../../core/utils_and_services/extensions/context_extensions.dart';
import '../../core/utils_and_services/dialog_managing/error_dialog.dart';
import '../../data/repositories/auth/auth_repository_provider.dart';
import '../../presentation/pages/reauthenticate_page.dart';
import '../../presentation/widgets/text_widget.dart';
import '../../presentation/widgets/custom_buttons.dart';
import '../../presentation/widgets/form_fields.dart';
import '../../features/input_forms/form_fields_models.dart';
import '../../features/input_forms/form_state_provider.dart';
import '../../features/input_forms/form_presets.dart';
import 'change_password_provider.dart';

part 'widgets_for_change_password.dart';

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
        appBar: AppBar(title: const Text('Change Password')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
          child: ListView(
            shrinkWrap: true,
            children: [
              const _ChangePasswordInfo(),
              const SizedBox(height: AppSpacing.m),
              for (final type in fields)
                FormBuilderField(
                  type: type,
                  fields: fields,
                  showToggleVisibility: true,
                ),
              const SizedBox(height: AppSpacing.l),
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
                label: state.isLoading ? 'Submitting...' : 'Change Password',
                isEnabled: !state.isLoading,
                isLoading: state.isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }

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

  Future<void> _processRequiresRecentLogin(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final result = await context.pushTo<String>(const ReAuthenticationPage());
    if (result == 'success') {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Successfully reauthenticated')),
      );
    }
  }

  ///
}
