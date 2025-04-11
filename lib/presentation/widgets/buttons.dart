import 'package:firebase_with_riverpod/core/utils_and_services/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

/// 🧩 Types of buttons available
enum ButtonType { filled, text }

/// 🍎 CustomButton - A modern iOS/macOS-style button with glass & dynamic visuals
class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final ButtonType type;
  final Color? foregroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Widget child;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.type,
    this.foregroundColor,
    this.fontSize = 17,
    this.fontWeight = FontWeight.w600,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final background =
        isDark
            ? Colors.white.withOpacity(0.05)
            : Colors.grey.shade100.withOpacity(0.4);

    final blurShadow = [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 0.5,
        offset: const Offset(2, 2),
      ),
      BoxShadow(
        color: Colors.white.withOpacity(0.3),
        blurRadius: 2,
        offset: const Offset(-2, -2),
      ),
    ];

    final borderRadius = BorderRadius.circular(12);

    return type == ButtonType.filled
        ? SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              color: background,
              borderRadius: borderRadius,
              boxShadow: blurShadow,
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: FilledButton(
              onPressed: onPressed,
              style: FilledButton.styleFrom(
                backgroundColor: background,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: borderRadius),
                textStyle: TextStyle(
                  fontFamily: 'SFProText',
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
              ),
              child: child,
            ),
          ),
        )
        : TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: foregroundColor ?? colorScheme.primary,
            textStyle: TextStyle(
              fontFamily: 'SFProText',
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          child: child,
        );
  }
}
