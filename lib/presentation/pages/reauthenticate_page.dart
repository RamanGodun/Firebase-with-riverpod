import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils_and_services/extensions/context_extensions.dart';
import '../../features/input_forms/form_fields_models.dart';
import '../../features/input_forms/form_state_provider.dart';
import '../../features/input_forms/form_presets.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/form_fields.dart';
import '../widgets/text_widget.dart';
import '../widgets/custom_app_bar.dart';

class ReAuthenticationPage extends ConsumerWidget {
  const ReAuthenticationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fields = FormTemplates.reAuthenticationFields;
    final provider = formStateNotifierProvider(fields);
    final form = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    final isFormValid = ref.watch(formValidProvider(fields));
    final submitting = ValueNotifier(false);

    return GestureDetector(
      onTap: context.unfocusKeyboard,
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Reauthenticate'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
          child: ValueListenableBuilder<bool>(
            valueListenable: submitting,
            builder:
                (context, isSubmitting, _) => ListView(
                  shrinkWrap: true,
                  children: [
                    const _ReauthenticateInfo(),
                    const SizedBox(height: AppSpacing.m),
                    for (final type in fields)
                      FormBuilderField(
                        type: type,
                        fields: fields,
                        showToggleVisibility: type == FormFieldType.password,
                      ),
                    const SizedBox(height: AppSpacing.l),
                    CustomButton(
                      type: ButtonType.filled,
                      label: isSubmitting ? 'Submitting...' : 'Reauthenticate',
                      isEnabled: !isSubmitting,
                      isLoading: isSubmitting,
                      onPressed:
                          isSubmitting
                              ? null
                              : () => _submit(
                                context,
                                form,
                                isFormValid,
                                notifier,
                                submitting,
                              ),
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }

  void _submit(
    BuildContext context,
    FormStateModel form,
    bool isFormValid,
    FormStateNotifier notifier,
    ValueNotifier<bool> submitting,
  ) {
    if (!isFormValid) {
      notifier.validateAll();
      return;
    }

    submitting.value = true;

    Future.delayed(const Duration(seconds: 2), () {
      if (!context.mounted) return;
      submitting.value = false;
      Navigator.pop(context, 'success');
    });
  }

  ///
}

///
///
class _ReauthenticateInfo extends StatelessWidget {
  const _ReauthenticateInfo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextWidget(
          'This is a security-sensitive operation, you must have recently signed in!',
          TextType.titleMedium,
          isTextOnFewStrings: true,
        ),
      ],
    );
  }
}
