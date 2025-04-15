import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/entities/custom_error.dart';
import '../../core/router/routes_names.dart';
import '../../core/utils_and_services/dialog_managing/error_dialog.dart';
import '../../core/utils_and_services/extensions/context_extensions.dart';
import '../../presentation/widgets/buttons/custom_buttons.dart';
import '../../presentation/widgets/text_widget.dart';
import '../input_forms/form_field_widget.dart';
import '../input_forms/form_fields_models.dart';
import '../../../features/input_forms/form_state_provider.dart';
import '../input_forms/form_presets.dart';
import 'reset_password_provider.dart';

part 'widgets_for_reset_password.dart';

class ResetPasswordPage extends ConsumerWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fields = FormTemplates.resetPasswordFields;
    final provider = formStateNotifierProvider(fields);
    final form = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    final isFormValid = ref.watch(formValidProvider(fields));
    final resetState = ref.watch(resetPasswordProvider);

    _listenForResetErrors(context, ref);

    return GestureDetector(
      onTap: context.unfocusKeyboard,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
              child: ListView(
                shrinkWrap: true,
                children: [
                  const _ResetPasswordHeader(),
                  const SizedBox(height: AppSpacing.l),
                  for (final type in fields)
                    AppFormField(type: type, fields: fields),
                  const SizedBox(height: AppSpacing.xxl),
                  CustomButton(
                    type: ButtonType.filled,
                    onPressed:
                        resetState.isLoading
                            ? null
                            : () {
                              if (isFormValid) {
                                ref
                                    .read(resetPasswordProvider.notifier)
                                    .resetPassword(
                                      email: form.valueOf(FormFieldType.email),
                                    );
                              } else {
                                notifier.validateAll();
                              }
                            },
                    label:
                        resetState.isLoading
                            ? 'Submitting...'
                            : 'Reset Password',
                    isLoading: resetState.isLoading,
                    isEnabled: !resetState.isLoading,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const _ResetPasswordFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _listenForResetErrors(BuildContext context, WidgetRef ref) {
    ref.listen(resetPasswordProvider, (prev, next) {
      next.whenOrNull(
        error:
            (e, _) => ErrorHandling.showErrorDialog(context, e as CustomError),
        data: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password reset email has been sent')),
          );
          if (context.mounted) context.goTo(RoutesNames.signin);
        },
      );
    });
  }
}
