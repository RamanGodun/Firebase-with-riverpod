import 'package:firebase_with_riverpod/core/utils_and_services/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/router/routes_names.dart';
import '../../core/utils_and_services/handle_exception.dart';
import '../../core/utils_and_services/extensions/context_extensions/_context_extensions.dart';
import '../../presentation/widgets/buttons/custom_buttons.dart';
import '../../presentation/widgets/text_widget.dart';
import '../input_forms/form_field_widget.dart';
import '../input_forms/form_fields_model.dart';
import '../../../features/input_forms/form_state_provider.dart';
import '../input_forms/presets_of_forms.dart';
import '../../core/utils_and_services/snackbars.dart';
import 'reset_password_provider.dart';

part 'widgets_for_reset_password.dart';

/// 🔐 [ResetPasswordPage] — screen that allows user to request password reset.
class ResetPasswordPage extends ConsumerWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldTypes = FormTemplates.resetPasswordFields;
    final formProvider = formStateNotifierProvider(fieldTypes);
    final formState = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);
    final isFormValid = ref.watch(formValidProvider(fieldTypes));
    final resetPasswordState = ref.watch(resetPasswordProvider);

    _listenForResetEvents(context, ref);

    /// used "LayoutBuilder + ConstrainedBox + IntrinsicHeight" pattern
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: FocusTraversalGroup(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          const _ResetPasswordHeader(),
                          const SizedBox(height: AppSpacing.l),
                          for (final type in fieldTypes)
                            AppFormField(type: type, fields: fieldTypes),
                          const SizedBox(height: AppSpacing.xxl),
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
                                    ? AppStrings.submitting
                                    : AppStrings.resetPassword,
                            isLoading: resetPasswordState.isLoading,
                            isEnabled: !resetPasswordState.isLoading,
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          const _ResetPasswordFooter(),
                        ],
                      ).withPaddingHorizontal(AppSpacing.l),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// 📡 Subscribes to [resetPasswordProvider] to handle success & error flows.
  void _listenForResetEvents(BuildContext context, WidgetRef ref) {
    ref.listen(resetPasswordProvider, (prev, next) {
      next.whenOrNull(
        error: (e, _) => context.showErrorDialog(handleException(e)),

        data: (_) {
          CustomSnackbars.show(
            ScaffoldMessenger.of(context),
            AppStrings.resetPasswordSuccess,
          );
          if (context.mounted) context.goTo(RoutesNames.signin);
        },
      );
    });
  }

  ///
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

  ///
}
