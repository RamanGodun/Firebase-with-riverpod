import 'package:firebase_with_riverpod/core/utils_and_services/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/router/routes_names.dart';
import '../../core/utils_and_services/extensions/context_extensions/_context_extensions.dart';
import '../input_forms/form_field_widget.dart';
import '../input_forms/form_fields_model.dart';
import '../input_forms/form_state_provider.dart';
import '../input_forms/presets_of_forms.dart';
import '../../presentation/widgets/buttons/custom_buttons.dart';
import '../../presentation/widgets/text_widget.dart';

/// 🔐 [ReAuthenticationPage] — screen used to re-authenticate the user before sensitive operations
class ReAuthenticationPage extends ConsumerWidget {
  const ReAuthenticationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldTypes = FormTemplates.reAuthenticationFields;
    final formProvider = formStateNotifierProvider(fieldTypes);
    final formState = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);
    final isFormValid = ref.watch(formValidProvider(fieldTypes));
    final submitting = ValueNotifier(false);

    /// used "LayoutBuilder + ConstrainedBox + IntrinsicHeight" pattern
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: FocusTraversalGroup(
                      child: ValueListenableBuilder<bool>(
                        valueListenable: submitting,
                        builder:
                            (context, isSubmitting, _) => ListView(
                              shrinkWrap: true,
                              children: [
                                const _ReauthenticateInfo(),

                                for (final type in fieldTypes)
                                  AppFormField(
                                    type: type,
                                    fields: fieldTypes,
                                    showToggleVisibility:
                                        type == FormFieldType.password,
                                  ),
                                const SizedBox(height: AppSpacing.l),

                                CustomButton(
                                  type: ButtonType.filled,
                                  label:
                                      isSubmitting
                                          ? AppStrings.submitting
                                          : AppStrings.reauthenticate,
                                  isEnabled: !isSubmitting,
                                  isLoading: isSubmitting,
                                  onPressed:
                                      isSubmitting
                                          ? null
                                          : () => _handleSubmit(
                                            context,
                                            formState,
                                            isFormValid,
                                            formNotifier,
                                            submitting,
                                          ),
                                ),
                              ],
                            ),
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

  /// ✅ Handles validation & simulates reauthentication submission
  void _handleSubmit(
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
}

/// ℹ️ [_ReauthenticateInfo] — informative section about re-authentication requirement
class _ReauthenticateInfo extends StatelessWidget {
  const _ReauthenticateInfo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextWidget(AppStrings.reauthenticateTitle, TextType.headlineMedium),
        TextWidget(
          AppStrings.reauthenticateDescription,
          TextType.titleSmall,
          isTextOnFewStrings: true,
        ),
        SizedBox(height: AppSpacing.m),
      ],
    );
  }
}
