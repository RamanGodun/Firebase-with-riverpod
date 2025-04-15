import 'package:firebase_with_riverpod/core/utils_and_services/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/router/routes_names.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils_and_services/dialog_managing/error_dialog.dart';
import '../../core/utils_and_services/helpers.dart';
import '../../core/entities/custom_error.dart';
import '../../presentation/widgets/old_buttons.dart';
import '../../presentation/widgets/custom_app_bar.dart';
import '../../presentation/widgets/form_fields_old.dart';
import '../../presentation/widgets/text_widget.dart';
import 'reset_password_provider.dart';

/// **Reset Password Page**
/// - Allows users to request a password reset email.
/// - Redirects users to the sign-in page after success.

class ResetPasswordPage extends ConsumerStatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _controllers = Helpers.createControllers(1);

  // =========== BUILD METHOD =========== //
  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      resetPasswordProvider,
      _handleResetPasswordState,
    );
    final resetPwdState = ref.watch(resetPasswordProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Reset Password'),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: ListView(
                shrinkWrap: true,
                reverse: true,
                children:
                    [
                      const _ResetPasswordHeader(),
                      _ResetPasswordFormField(
                        controller: _controllers[0],
                      ), // ✅ Без const
                      _ResetPasswordSubmitButton(
                        resetPwdState: resetPwdState,
                        onSubmit: _submit,
                      ),
                      const _ResetPasswordFooter(),
                    ].reversed.toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =========== PROVIDER LISTENING =========== //
  void _handleResetPasswordState(
    AsyncValue<void>? previous,
    AsyncValue<void> next,
  ) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    next.whenOrNull(
      error:
          (e, st) => ErrorHandling.showErrorDialog(context, e as CustomError),
      data: (_) {
        Helpers.showSnackbar(
          scaffoldMessenger,
          'Password reset email has been sent',
        );

        if (!context.mounted) return;
        context.goTo(RoutesNames.signin);
      },
    );
  }

  // =========== SUBMIT METHOD =========== //
  void _submit() {
    setState(() => _autovalidateMode = AutovalidateMode.always);

    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    ref
        .read(resetPasswordProvider.notifier)
        .resetPassword(email: _controllers[0].text.trim());
  }

  // =========== DISPOSE METHOD =========== //
  @override
  void dispose() {
    Helpers.disposeControllers(_controllers);
    super.dispose();
  }
}

// =========== STATIC WIDGETS =========== //

/// **Header Section**
/// Displays app logo and spacing.
class _ResetPasswordHeader extends StatelessWidget {
  const _ResetPasswordHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [FlutterLogo(size: 150), SizedBox(height: AppSpacing.m)],
    );
  }
}

/// **Form Field**
/// Displays an email input field for password reset.
class _ResetPasswordFormField extends StatelessWidget {
  final TextEditingController controller;

  const _ResetPasswordFormField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomFormField(type: FormFieldType.email, controller: controller);
  }
}

/// **Submit Button**
/// - Triggers the reset password request.
class _ResetPasswordSubmitButton extends StatelessWidget {
  final AsyncValue<void> resetPwdState;
  final VoidCallback onSubmit;

  const _ResetPasswordSubmitButton({
    required this.resetPwdState,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      type: ButtonType.filled,
      onPressed: resetPwdState.maybeWhen(
        loading: () => null,
        orElse: () => onSubmit,
      ),
      label: resetPwdState.maybeWhen(
        loading: () => 'Submitting...',
        orElse: () => 'Reset Password',
      ),
      isLoading: resetPwdState.isLoading,
      isEnabled: !resetPwdState.isLoading,
    );
  }
}

/// **Footer Section**
/// - Provides a link to return to the Sign-In page.
class _ResetPasswordFooter extends StatelessWidget {
  const _ResetPasswordFooter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.m),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextWidget('Remember password? ', TextType.bodyMedium),
          CustomButton(
            type: ButtonType.text,
            onPressed: () => context.goTo(RoutesNames.signin),
            label: 'Sign In',
            isEnabled: true,
            isLoading: false,
          ),
        ],
      ),
    );
  }
}
