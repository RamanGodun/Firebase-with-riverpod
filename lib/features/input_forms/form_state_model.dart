part of 'form_fields_model.dart';

/// 🧾 Model representing the entire form state
@immutable
class FormStateModel extends Equatable {
  final Map<FormFieldType, FieldModel> fields;

  const FormStateModel(this.fields);

  bool get isValid => fields.values.every((f) => f.isValid);
  String? errorFor(FormFieldType type) => fields[type]?.error;
  String valueOf(FormFieldType type) => fields[type]?.value ?? '';

  @override
  List<Object?> get props => [fields];
}
