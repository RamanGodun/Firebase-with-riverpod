import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

enum FormFieldType { confirmPassword, password, email, name }

class CustomFormField extends StatefulWidget {
  final FormFieldType type;
  final TextEditingController controller;
  final TextEditingController? confirmController;
  final String? labelText;
  final bool showToggleVisibility;

  const CustomFormField({
    super.key,
    required this.type,
    required this.controller,
    this.confirmController,
    this.labelText,
    this.showToggleVisibility = false,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _obscureText = true;

  bool get _isPasswordType =>
      widget.type == FormFieldType.password ||
      widget.type == FormFieldType.confirmPassword;

  @override
  Widget build(BuildContext context) {
    final effectiveLabel = widget.labelText ?? _getLabelText();

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _isPasswordType && _obscureText,
        keyboardType:
            widget.type == FormFieldType.email
                ? TextInputType.emailAddress
                : TextInputType.text,
        autocorrect: widget.type != FormFieldType.email,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          filled: true,
          labelText: effectiveLabel,
          prefixIcon: _getIcon(),
          suffixIcon:
              _isPasswordType && widget.showToggleVisibility
                  ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed:
                        () => setState(() => _obscureText = !_obscureText),
                  )
                  : null,
        ),
        validator: _buildValidator(),
      ),
    );
  }

  String _getLabelText() {
    switch (widget.type) {
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
    switch (widget.type) {
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
    switch (widget.type) {
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
          if (value.trim() != widget.confirmController?.text.trim()) {
            return 'Passwords do not match';
          }
          return null;
        };
    }
  }
}
