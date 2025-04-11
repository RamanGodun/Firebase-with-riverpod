import 'package:firebase_with_riverpod/core/utils_and_services/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../data/repositories/auth/auth_repository_provider.dart';
import '../../core/utils_and_services/dialog_managing/error_dialog.dart';
import '../../core/utils_and_services/helpers.dart';
import '../../core/entities/custom_error.dart';
import '../../presentation/widgets/buttons.dart';
import '../../presentation/widgets/custom_app_bar.dart';
import '../../presentation/widgets/form_fields.dart';
import '../../presentation/widgets/text_widget.dart';
import '../../presentation/pages/reauthenticate_page.dart';
import 'change_password_provider.dart';

/// **Change Password Page**
/// - Handles user password updates.
/// - Requires recent authentication for security-sensitive actions.
class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  /// **Окремий контролер для підтвердження пароля**
  final _controllers = Helpers.createControllers(2);

  // =========== Build method =========== //

  @override
  Widget build(BuildContext context) {
    _listenToPasswordChange();
    final chgPwdState = ref.watch(changePasswordProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Change Password'),
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
                      const _ChangePasswordInfo(),
                      _ChangePasswordFormFields(
                        passwordController: _controllers[0],
                        confirmPasswordController: _controllers[1],
                      ),
                      _ChangePasswordSubmitButton(
                        chgPwdState: chgPwdState,
                        onSubmit: _submit,
                      ),
                      const SizedBox(height: AppSpacing.s),
                    ].reversed.toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =========== Provider listening  =========== //

  void _listenToPasswordChange() {
    ref.listen<AsyncValue<void>>(changePasswordProvider, (previous, next) {
      next.whenOrNull(
        error: (e, st) {
          final err = e as CustomError;
          err.code == 'requires-recent-login'
              ? _processRequiresRecentLogin()
              : ErrorHandling.showErrorDialog(context, err);
        },
        data: (_) => _processSuccessCase(),
      );
    });
  }

  // =========== Success handling  =========== //

  Future<void> _processSuccessCase() async {
    try {
      await ref.read(authRepositoryProvider).signout();
    } on CustomError catch (e) {
      if (!mounted) return;
      ErrorHandling.showErrorDialog(context, e);
    }
  }

  // =========== Reauthentication prompt =========== //

  Future<void> _processRequiresRecentLogin() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // 📦 Push ReauthenticationPage and wait for result
    final result = await context.pushTo<String>(const ReAuthenticationPage());

    if (result == 'success') {
      Helpers.showSnackbar(scaffoldMessenger, 'Successfully reauthenticated');
    }
  }
  //context.pushToNamed(RoutesNames.home)
  // =========== Submit method =========== //

  void _submit() {
    setState(() => _autovalidateMode = AutovalidateMode.always);
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    ref
        .read(changePasswordProvider.notifier)
        .changePassword(_controllers[0].text.trim());
  }

  // =========== Dispose method =========== //

  @override
  void dispose() {
    Helpers.disposeControllers(_controllers);
    super.dispose();
  }
}

// =========== STATIC WIDGETS =========== //

// =========== CHANGE PASSWORD WIDGETS =========== //

/// **Change Password Info Section**
/// - Displays warning message that the user will be signed out.
class _ChangePasswordInfo extends StatelessWidget {
  const _ChangePasswordInfo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextWidget('If you change your password,', TextType.bodyMedium),
        Text.rich(
          TextSpan(
            text: 'you will be ',
            style: TextStyle(color: Colors.black, fontSize: 18),
            children: [
              TextSpan(
                text: 'signed out!',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppSpacing.m),
      ],
    );
  }
}

// =========== CHANGE PASSWORD FORM FIELDs WIDGETS =========== //

/// **Password Form Fields Section**
/// - Includes password and confirm password fields.
class _ChangePasswordFormFields extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const _ChangePasswordFormFields({
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomFormField(
          type: FormFieldType.password,
          controller: passwordController,
          labelText: 'New password',
        ),
        const SizedBox(height: AppSpacing.s),
        CustomFormField(
          type: FormFieldType.confirmPassword,
          controller: confirmPasswordController,
          confirmController: passwordController,
          labelText: 'Confirm new password',
        ),
      ],
    );
  }
}

// =========== CHANGE PASSWORD SUBMIT WIDGETS =========== //
/// **Submit Button Section**
/// - Handles form submission with state validation.
class _ChangePasswordSubmitButton extends StatelessWidget {
  final AsyncValue<void> chgPwdState;
  final VoidCallback onSubmit;

  const _ChangePasswordSubmitButton({
    required this.chgPwdState,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      type: ButtonType.filled,
      onPressed: chgPwdState.maybeWhen(
        loading: () => null,
        orElse: () => onSubmit,
      ),
      label: chgPwdState.maybeWhen(
        loading: () => 'Submitting...',
        orElse: () => 'Change Password',
      ),
      isLoading: chgPwdState.isLoading,
      isEnabled: chgPwdState.hasValue,
    );
  }
}
