import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils_and_services/helpers.dart';
import '../widgets/buttons.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/form_fields.dart';
import '../widgets/text_widget.dart';

/// **Reauthentication Page**
/// - Ensures the user has recently signed in before performing security-sensitive actions.
class ReauthenticatePage extends ConsumerStatefulWidget {
  const ReauthenticatePage({super.key});

  @override
  ConsumerState<ReauthenticatePage> createState() => _ReauthenticatePageState();
}

class _ReauthenticatePageState extends ConsumerState<ReauthenticatePage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _controllers = Helpers.createControllers(2);
  bool _submitting = false;

  // =========== BUILD METHOD =========== //
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Reauthenticate'),
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
                      const _ReauthenticateInfo(),
                      _ReauthenticateFormFields(
                        controllers: _controllers,
                      ), // ✅ Без const
                      _ReauthenticateSubmitButton(
                        submitting: _submitting,
                        onSubmit: _submit,
                      ),
                    ].reversed.toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =========== SUBMIT METHOD =========== //
  void _submit() {
    setState(() => _autovalidateMode = AutovalidateMode.always);
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    setState(() => _submitting = true);

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      setState(() => _submitting = false);

      /// ✅ Якщо все ок – повертаємо "success"
      Navigator.pop(context, 'success');
    });
  }

  // =========== DISPOSE METHOD =========== //
  @override
  void dispose() {
    Helpers.disposeControllers(_controllers);
    super.dispose();
  }
}

// =========== STATIC WIDGETS =========== //

/// **Reauthentication Info Section**
/// - Displays instructions for the user.
class _ReauthenticateInfo extends StatelessWidget {
  const _ReauthenticateInfo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextWidget(
          'This is a security-sensitive operation\nyou must have recently signed in!',
          TextType.bodyMedium,
        ),
        SizedBox(height: AppSpacing.m),
      ],
    );
  }
}

/// **Form Fields Section**
/// - Collects email and password for reauthentication.
class _ReauthenticateFormFields extends StatelessWidget {
  final List<TextEditingController> controllers;

  const _ReauthenticateFormFields({required this.controllers});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomFormField(type: FormFieldType.email, controller: controllers[0]),
        const SizedBox(height: AppSpacing.s),
        CustomFormField(
          type: FormFieldType.password,
          controller: controllers[1],
          labelText: 'Password',
        ),
      ],
    );
  }
}

/// **Submit Button Section**
/// - Handles form submission with state validation.
class _ReauthenticateSubmitButton extends StatelessWidget {
  final bool submitting;
  final VoidCallback onSubmit;

  const _ReauthenticateSubmitButton({
    required this.submitting,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      type: ButtonType.filled,
      onPressed: submitting ? null : onSubmit,
      child: TextWidget(
        submitting ? 'Submitting...' : 'Reauthenticate',
        TextType.button,
      ),
    );
  }
}
