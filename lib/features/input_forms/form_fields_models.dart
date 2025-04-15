import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Типи полів, що використовуються у формах
enum FormFieldType { name, email, password, confirmPassword }

/// Модель одного поля форми з валідацією та dirty-станом
@immutable
class FieldModel extends Equatable {
  final String value;
  final bool dirty;
  final String? error;

  const FieldModel({this.value = '', this.dirty = false, this.error});

  /// Копіює обʼєкт з новими значеннями
  FieldModel copyWith({String? value, bool? dirty, String? error}) {
    return FieldModel(
      value: value ?? this.value,
      dirty: dirty ?? this.dirty,
      error: error,
    );
  }

  /// Перевірка валідності поля
  bool get isValid => error == null && value.trim().isNotEmpty;

  @override
  List<Object?> get props => [value, dirty, error];
}

/// Модель стану всієї форми
@immutable
class FormStateModel extends Equatable {
  final Map<FormFieldType, FieldModel> fields;

  const FormStateModel(this.fields);

  /// Чи всі поля валідні
  bool get isValid => fields.values.every((f) => f.isValid);

  /// Отримати помилку по полю
  String? errorFor(FormFieldType type) => fields[type]?.error;

  /// Отримати значення поля
  String valueOf(FormFieldType type) => fields[type]?.value ?? '';

  @override
  List<Object?> get props => [fields];
}
