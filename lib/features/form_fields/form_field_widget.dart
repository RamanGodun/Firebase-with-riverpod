import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_riverpod/core/shared_modules/theme/extensions/theme_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/shared_layers/shared_presentation/constants/_app_constants.dart';
import '../../core/shared_modules/localization/generated/locale_keys.g.dart';
import 'form_fields_model.dart';
import 'form_state_provider.dart';

/// ✅ [AppFormField] — universal reactive form input field (Hooked + Riverpod powered)
class AppFormField extends HookConsumerWidget {
  final FormFieldType type;
  final List<FormFieldType> fields;
  final bool showToggleVisibility;

  const AppFormField({
    super.key,
    required this.type,
    required this.fields,
    this.showToggleVisibility = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 🔁 Controller to manage input value
    final controller = useTextEditingController();
    // 👁️ State for obscuring password text
    final obscure = useState(true);

    /// 📦 Provider to watch form state and notifier
    final formProvider = formStateNotifierProvider(fields);
    final formState = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);

    /// 🧠 Sync initial value + listen to controller text changes
    useEffect(() {
      controller.text = formState.valueOf(type);
      controller.addListener(
        () => formNotifier.updateField(type, controller.text),
      );
      return null;
    }, [controller]);

    /// 🔐 Field type checks
    final isPasswordField =
        type == FormFieldType.password || type == FormFieldType.confirmPassword;
    final isEmailField = type == FormFieldType.email;

    /// 🧱 TextFormField UI
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s),
      child: TextFormField(
        controller: controller,
        obscureText: isPasswordField && obscure.value,
        keyboardType:
            isEmailField ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          border: const OutlineInputBorder(borderRadius: UIConstants.bRadius13),
          labelText: _labelFor(type),
          errorText: formState.errorFor(type),
          prefixIcon: _iconFor(type),

          // 👁️ Show toggle visibility icon for password fields
          suffixIcon:
              isPasswordField && showToggleVisibility
                  ? IconButton(
                    icon: Icon(
                      obscure.value ? Icons.visibility_off : Icons.visibility,
                      color: context.colorScheme.primary,
                    ),
                    onPressed: () => obscure.value = !obscure.value,
                  )
                  : null,
        ),
      ),
    );
  }

  /// 🏷 Returns label text based on [FormFieldType]
  String _labelFor(FormFieldType type) => switch (type) {
    FormFieldType.name => LocaleKeys.form_name.tr(),
    FormFieldType.email => LocaleKeys.form_email.tr(),
    FormFieldType.password => LocaleKeys.form_password.tr(),
    FormFieldType.confirmPassword => LocaleKeys.form_confirm_password.tr(),
  };

  /// 🔣 Returns prefix icon based on [FormFieldType]
  Icon _iconFor(FormFieldType type) => switch (type) {
    FormFieldType.email => const Icon(Icons.email),
    FormFieldType.password ||
    FormFieldType.confirmPassword => const Icon(Icons.lock),
    FormFieldType.name => const Icon(Icons.person),
  };
}
