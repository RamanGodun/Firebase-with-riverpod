import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'form_state_model.dart';

/// 📦 Model representing individual field state

@immutable
class FieldModel extends Equatable {
  ///------------------------------

  final String value;
  final bool dirty;
  final String? error;

  const FieldModel({this.value = '', this.dirty = false, this.error});
  //

  ///
  FieldModel copyWith({String? value, bool? dirty, String? error}) =>
      FieldModel(
        value: value ?? this.value,
        dirty: dirty ?? this.dirty,
        error: error,
      );

  ///
  bool get isValid => error == null && value.trim().isNotEmpty;

  ///
  @override
  List<Object?> get props => [value, dirty, error];

  //
}

////

////

/// 🧾 Enum representing supported form field types
enum FormFieldType { name, email, password, confirmPassword }
