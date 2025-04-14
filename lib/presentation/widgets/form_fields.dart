import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

enum FormFieldType { confirmPassword, password, email, name }

class CustomFormField extends StatelessWidget {
  final FormFieldType type;
  final TextEditingController controller;
  final TextEditingController? confirmController;
  final String? labelText;

  const CustomFormField({
    super.key,
    required this.type,
    required this.controller,
    this.confirmController,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveLabel = labelText ?? _getLabelText();

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText:
            type == FormFieldType.password ||
            type == FormFieldType.confirmPassword,
        keyboardType:
            type == FormFieldType.email
                ? TextInputType.emailAddress
                : TextInputType.text,
        autocorrect: type != FormFieldType.email,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          filled: true,
          labelText: effectiveLabel,
          prefixIcon: _getIcon(),
        ),
        validator: _buildValidator(),
      ),
    );
  }

  // ------------------ PRIVATE METHODS ------------------ //

  String _getLabelText() {
    switch (type) {
      case FormFieldType.password:
        return 'Password';
      case FormFieldType.confirmPassword:
        return 'Confirm password';
      case FormFieldType.email:
        return 'Email';
      case FormFieldType.name:
        return 'Name';
    }
  }

  Icon _getIcon() {
    switch (type) {
      case FormFieldType.password:
      case FormFieldType.confirmPassword:
        return const Icon(Icons.lock);
      case FormFieldType.email:
        return const Icon(Icons.email);
      case FormFieldType.name:
        return const Icon(Icons.account_box);
    }
  }

  String? Function(String?) _buildValidator() {
    switch (type) {
      case FormFieldType.email:
        return ValidationBuilder()
            .required('Email required')
            .email('Enter a valid email')
            .build();
      case FormFieldType.password:
        return ValidationBuilder()
            .required('Password required')
            .minLength(6, 'Password must be at least 6 characters')
            .build();
      case FormFieldType.name:
        return ValidationBuilder()
            .required('Name required')
            .minLength(2, 'Minimum 2 characters')
            .maxLength(12, 'Maximum 12 characters')
            .build();
      case FormFieldType.confirmPassword:
        return (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Confirm password required';
          }
          if (value.trim() != confirmController?.text.trim()) {
            return 'Passwords do not match';
          }
          return null;
        };
    }
  }
}
