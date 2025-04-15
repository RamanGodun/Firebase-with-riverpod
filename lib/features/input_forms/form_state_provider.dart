// 🔹 2. form_state_provider.dart
import 'package:form_validator/form_validator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'form_fields_models.dart';

part 'form_state_provider.g.dart';

@riverpod
class FormStateNotifier extends _$FormStateNotifier {
  late final List<FormFieldType> _activeFields;

  @override
  FormStateModel build(List<FormFieldType> fields) {
    _activeFields = fields;
    return FormStateModel({for (final f in fields) f: const FieldModel()});
  }

  void updateField(FormFieldType type, String value) {
    final validator = _validatorFor(type);
    final error = validator(value);
    state = FormStateModel({
      ...state.fields,
      type: state.fields[type]!.copyWith(
        value: value,
        dirty: true,
        error: error,
      ),
    });
  }

  void validateAll() {
    for (final type in _activeFields) {
      final value = state.fields[type]!.value;
      updateField(type, value);
    }
  }

  String? Function(String) _validatorFor(FormFieldType type) {
    switch (type) {
      case FormFieldType.email:
        return ValidationBuilder()
            .required('Required')
            .email('Invalid email')
            .build();
      case FormFieldType.password:
        return ValidationBuilder().required('Required').minLength(6).build();
      case FormFieldType.name:
        return ValidationBuilder()
            .required('Required')
            .minLength(2)
            .maxLength(12)
            .build();
      case FormFieldType.confirmPassword:
        final original = state.fields[FormFieldType.password]?.value ?? '';
        return (value) {
          if (value.trim().isEmpty) return 'Confirm password required';
          if (value.trim() != original.trim()) return 'Passwords do not match';
          return null;
        };
    }
  }
}

/// Provider to get current form validity reactively
final formValidProvider = Provider.autoDispose
    .family<bool, List<FormFieldType>>(
      (ref, fields) => ref.watch(formStateNotifierProvider(fields)).isValid,
    );
