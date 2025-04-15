import 'package:form_validator/form_validator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'form_fields_models.dart';

part 'form_state_provider.g.dart';

@riverpod
class FormStateNotifier extends _$FormStateNotifier {
  late final List<FormFieldType> _activeFields;

  @override
  FormStateModel build(List<FormFieldType> activeFields) {
    _activeFields = activeFields;
    final initial = {
      for (final field in activeFields) field: const FieldModel(),
    };
    return FormStateModel(initial);
  }

  bool isActive(FormFieldType type) => _activeFields.contains(type);

  void updateField(FormFieldType type, String value) {
    if (!isActive(type)) return;
    final validator = _getValidator(type);
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

  String? Function(String) _getValidator(FormFieldType type) {
    switch (type) {
      case FormFieldType.email:
        return ValidationBuilder()
            .required('Email required')
            .email('Enter a valid email')
            .build();
      case FormFieldType.password:
        return ValidationBuilder()
            .required('Password required')
            .minLength(6, 'Minimum 6 characters')
            .build();
      case FormFieldType.name:
        return ValidationBuilder()
            .required('Name required')
            .minLength(2, 'Min 2')
            .maxLength(12, 'Max 12')
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

  void validateAll() {
    for (final field in _activeFields) {
      updateField(field, state.fields[field]!.value);
    }
  }
}

/// ✅ "Is form valid?" computed Provider:
final formValidProvider = Provider.autoDispose
    .family<bool, List<FormFieldType>>(
      (ref, fields) => ref.watch(formStateNotifierProvider(fields)).isValid,
    );
