import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// Enum of supported form fields
enum FormFieldType { name, email, password, confirmPassword }

/// Model representing a single field
@immutable
class FieldModel extends Equatable {
  final String value;
  final bool dirty;
  final String? error;

  const FieldModel({this.value = '', this.dirty = false, this.error});

  FieldModel copyWith({String? value, bool? dirty, String? error}) =>
      FieldModel(
        value: value ?? this.value,
        dirty: dirty ?? this.dirty,
        error: error,
      );

  bool get isValid => error == null && value.trim().isNotEmpty;

  @override
  List<Object?> get props => [value, dirty, error];
}

/// Entire form state, holding all fields
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
