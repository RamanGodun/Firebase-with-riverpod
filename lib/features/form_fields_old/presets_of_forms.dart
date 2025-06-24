// 🔹 form_presets.dart
import 'form_fields_model.dart';

/// 🧩 Field combinations for various forms

class FormTemplates {
  ///---------------

  static const List<FormFieldType> signInFields = [
    FormFieldType.email,
    FormFieldType.password,
  ];

  static const List<FormFieldType> signUpFields = [
    FormFieldType.name,
    FormFieldType.email,
    FormFieldType.password,
    FormFieldType.confirmPassword,
  ];

  static const List<FormFieldType> resetPasswordFields = [FormFieldType.email];

  static const List<FormFieldType> changePasswordFields = [
    FormFieldType.password,
    FormFieldType.confirmPassword,
  ];

  static const List<FormFieldType> reAuthenticationFields = [
    FormFieldType.email,
    FormFieldType.password,
  ];

  //
}
