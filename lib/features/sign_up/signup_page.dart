import 'package:firebase_with_riverpod/core/utils_and_services/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/router/routes_names.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils_and_services/dialog_managing/error_dialog.dart';
import '../../core/utils_and_services/helpers.dart';
import '../../core/entities/custom_error.dart';
import '../../presentation/widgets/buttons.dart';
import '../../presentation/widgets/custom_app_bar.dart';
import '../../presentation/widgets/form_fields.dart';
import '../../presentation/widgets/text_widget.dart';
import 'signup_provider.dart';

/// **Sign Up Page**
/// - Allows users to create an account.
/// - Provides a link to sign in for existing users.
class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.unfocusKeyboard,
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Sign Up'),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
            child: ListView(
              shrinkWrap: true,
              children: const [
                _SignupHeader(),
                SignupFormFields(),
                _SignupFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =========== FORM FIELDS WIDGET =========== //

/// **Sign-up Form**
/// - Collects user details (name, email, password).
/// - Handles form validation and submission.
class SignupFormFields extends ConsumerStatefulWidget {
  const SignupFormFields({super.key});

  @override
  ConsumerState<SignupFormFields> createState() => _SignupFormFieldsState();
}

class _SignupFormFieldsState extends ConsumerState<SignupFormFields> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _controllers = Helpers.createControllers(4);

  // =========== BUILD METHOD =========== //
  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(signupProvider, _handleSignupError);
    final signupState = ref.watch(signupProvider);

    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomFormField(
            type: FormFieldType.name,
            controller: _controllers[0],
          ),
          CustomFormField(
            type: FormFieldType.email,
            controller: _controllers[1],
          ),
          CustomFormField(
            type: FormFieldType.password,
            controller: _controllers[2],
          ),
          CustomFormField(
            type: FormFieldType.confirmPassword,
            controller: _controllers[3],
            confirmController: _controllers[2],
          ),
          const SizedBox(height: AppSpacing.l),
          CustomButton(
            type: ButtonType.filled,
            onPressed: signupState.maybeWhen(
              loading: () => null,
              orElse: () => _submit,
            ),
            child: TextWidget(
              signupState.maybeWhen(
                loading: () => 'Submitting...',
                orElse: () => 'Sign Up',
              ),
              TextType.button,
            ),
          ),
        ],
      ),
    );
  }

  // =========== PROVIDER LISTENING =========== //
  void _handleSignupError(AsyncValue<void>? _, AsyncValue<void> next) =>
      next.whenOrNull(
        error:
            (e, st) => ErrorHandling.showErrorDialog(context, e as CustomError),
      );

  // =========== SUBMIT METHOD =========== //
  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    ref
        .read(signupProvider.notifier)
        .signup(
          name: _controllers[0].text.trim(),
          email: _controllers[1].text.trim(),
          password: _controllers[2].text.trim(),
        );
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
class _SignupHeader extends StatelessWidget {
  const _SignupHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [FlutterLogo(size: 150), SizedBox(height: AppSpacing.m)],
    );
  }
}

/// **Footer Section**
/// - Provides a link to sign in for existing users.
class _SignupFooter extends StatelessWidget {
  const _SignupFooter();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const TextWidget('Already a member? ', TextType.titleSmall),
        CustomButton(
          type: ButtonType.text,
          onPressed: () => context.goTo(RoutesNames.signin),
          child: const TextWidget('Sign In!', TextType.error),
        ),
      ],
    );
  }
}
