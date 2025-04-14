import 'package:firebase_with_riverpod/core/utils_and_services/extensions/others.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_with_riverpod/core/constants/app_constants.dart';
import 'package:firebase_with_riverpod/core/router/routes_names.dart';
import 'package:firebase_with_riverpod/core/utils_and_services/dialog_managing/error_dialog.dart';
import 'package:firebase_with_riverpod/core/utils_and_services/extensions/context_extensions.dart';
import 'package:firebase_with_riverpod/core/utils_and_services/helpers.dart';
import 'package:firebase_with_riverpod/core/entities/custom_error.dart';
import 'package:firebase_with_riverpod/presentation/widgets/buttons.dart';
import 'package:firebase_with_riverpod/presentation/widgets/custom_app_bar.dart';
import 'package:firebase_with_riverpod/presentation/widgets/form_fields.dart';
import 'package:firebase_with_riverpod/presentation/widgets/text_widget.dart';
import 'signin_provider.dart';

part 'widgets_for_signin_page.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.unfocusKeyboard,
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Sign In', isCenteredTitle: true),
        body: Center(
          child: const _SigninFormWrapper().withPaddingHorizontal(AppSpacing.l),
        ),
      ),
    );
  }
}

class _SigninFormWrapper extends ConsumerStatefulWidget {
  const _SigninFormWrapper();

  @override
  ConsumerState<_SigninFormWrapper> createState() => _SigninFormWrapperState();
}

class _SigninFormWrapperState extends ConsumerState<_SigninFormWrapper> {
  final _formKey = GlobalKey<FormState>();
  final _controllers = Helpers.createControllers(2);
  AutovalidateMode _autovalidateMode = AutovalidateMode.onUserInteraction;

  @override
  Widget build(BuildContext context) {
    ref.listen(signinProvider, _handleSigninError);
    final state = ref.watch(signinProvider);

    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: ListView(
        shrinkWrap: true,
        children: [
          const _SigninHeader(),
          CustomFormField(
            type: FormFieldType.email,
            controller: _controllers[0],
          ),
          CustomFormField(
            type: FormFieldType.password,
            controller: _controllers[1],
          ),
          const SizedBox(height: AppSpacing.xl),
          CustomButton(
            type: ButtonType.filled,
            onPressed: state.isLoading ? null : _submit,
            label: state.isLoading ? 'Submitting...' : 'Sign In',
            isEnabled: !state.isLoading,
            isLoading: state.isLoading,
          ),
          const _SigninFooter(),
        ],
      ),
    );
  }

  /// * USED methods
  /// ---------------------------------------------------

  void _handleSigninError(AsyncValue<void>? _, AsyncValue<void> next) {
    next.whenOrNull(
      error: (e, st) {
        if (!context.mounted) return;
        ErrorHandling.showErrorDialog(context, e as CustomError);
      },
    );
  }

  void _submit() {
    setState(() => _autovalidateMode = AutovalidateMode.always);
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    ref
        .read(signinProvider.notifier)
        .signin(
          email: _controllers[0].text.trim(),
          password: _controllers[1].text.trim(),
        );
  }

  @override
  void dispose() {
    Helpers.disposeControllers(_controllers);
    super.dispose();
  }

  ///
}
