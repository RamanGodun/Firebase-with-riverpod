import 'package:firebase_with_riverpod/core/utils_and_services/extensions/others.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/router/routes_names.dart';
import '../../core/utils_and_services/extensions/context_extensions.dart';
import '../input_forms/form_fields_models.dart';
import '../input_forms/form_state_provider.dart';
import '../input_forms/form_presets.dart';
import '../../presentation/widgets/custom_buttons.dart';
import '../../presentation/widgets/form_fields.dart';
import '../../presentation/widgets/text_widget.dart';

part 'widget_for_re_auth_info.dart';

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
        appBar: AppBar(),
        body: Center(
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
          ).withPaddingHorizontal(AppSpacing.l),
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
      context.goTo(RoutesNames.home);
    });
  }

  ///
}
