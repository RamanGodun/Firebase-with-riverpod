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
import 'signin_provider.dart';

/// **Sign In Page**
/// - Allows users to log in with their credentials.
/// - Provides links for signing up and password recovery.

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Helpers.unfocus(context),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Sign In'),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
            child: ListView(
              shrinkWrap: true,

              children: const [
                _SigninHeader(),
                SigninFormFields(),
                _SigninFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =========== FORM FIELDS WIDGET =========== //

/// **Sign-in Form**
/// - Collects email and password for authentication.
/// - Handles form validation and submission.
class SigninFormFields extends ConsumerStatefulWidget {
  const SigninFormFields({super.key});

  @override
  ConsumerState<SigninFormFields> createState() => _SigninFormFieldsState();
}

class _SigninFormFieldsState extends ConsumerState<SigninFormFields> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _controllers = Helpers.createControllers(2);

  // =========== BUILD METHOD =========== //

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(signinProvider, _handleSigninError);
    final signinState = ref.watch(signinProvider);

    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: Column(
        children: [
          CustomFormField(
            type: FormFieldType.email,
            controller: _controllers[0],
          ),
          CustomFormField(
            type: FormFieldType.password,
            controller: _controllers[1],
            labelText: 'Password',
          ),
          const SizedBox(height: AppSpacing.xl),
          CustomButton(
            type: ButtonType.filled,
            onPressed: signinState.maybeWhen(
              loading: () => null,
              orElse: () => _submit,
            ),
            child: TextWidget(
              signinState.maybeWhen(
                loading: () => 'Submitting...',
                orElse: () => 'Sign In',
              ),
              TextType.button,
            ),
          ),
        ],
      ),
    );
  }

  // =========== PROVIDER LISTENING =========== //

  void _handleSigninError(AsyncValue<void>? _, AsyncValue<void> next) {
    next.whenOrNull(
      error: (e, st) {
        if (!context.mounted) return;
        ErrorHandling.showErrorDialog(context, e as CustomError);
      },
    );
  }

  // =========== SUBMIT METHOD =========== //

  void _submit() {
    setState(
      () => _autovalidateMode = AutovalidateMode.always,
    ); // ✅ Включає валідацію

    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    ref
        .read(signinProvider.notifier)
        .signin(
          email: _controllers[0].text.trim(),
          password: _controllers[1].text.trim(),
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
class _SigninHeader extends StatelessWidget {
  const _SigninHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [FlutterLogo(size: 150), SizedBox(height: AppSpacing.m)],
    );
  }
}

/// **Footer Section**
/// - Provides links for sign-up and password recovery.
class _SigninFooter extends StatelessWidget {
  const _SigninFooter();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: AppSpacing.l),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextWidget('Not a member? ', TextType.titleSmall),
            CustomButton(
              type: ButtonType.text,
              onPressed: () => Helpers.goTo(context, RoutesNames.signup),
              child: const TextWidget(
                'Sign Up!',
                TextType.error,
                color: AppConstants.errorColor,
                isUnderlined: true,
              ),
            ),
          ],
        ),
        CustomButton(
          type: ButtonType.text,
          onPressed: () => Helpers.goTo(context, RoutesNames.resetPassword),
          foregroundColor: Colors.red,
          child: const TextWidget('Forgot Password?', TextType.error),
        ),
      ],
    );
  }
}
