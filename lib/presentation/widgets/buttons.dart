import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/utils_and_services/extensions/context_extensions.dart';
import 'text_widget.dart';

enum ButtonType { filled, text }

/// 🍎 [CustomButton] — macOS/iOS-styled button with loading and enabled states
class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final ButtonType type;
  final bool isLoading;
  final bool isEnabled;
  final String label;
  final Color? foregroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.type,
    this.isLoading = false,
    this.isEnabled = true,
    this.foregroundColor,
    this.fontSize = 17,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final isDark = context.isDarkMode;
    final borderRadius = BorderRadius.circular(14);

    final baseColor =
        type == ButtonType.filled
            ? (isDark
                ? Colors.white.withOpacity(0.05)
                : scheme.primary.withOpacity(0.08))
            : Colors.transparent;

    final textColor =
        type == ButtonType.filled
            ? Colors.white
            : foregroundColor ?? scheme.primary;

    final shadow =
        type == ButtonType.filled
            ? [
              BoxShadow(
                color:
                    isDark
                        ? Colors.black.withOpacity(0.2)
                        : Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ]
            : null;

    final content =
        isLoading
            ? const CupertinoActivityIndicator(radius: 12, color: Colors.white)
            : TextWidget(
              label,
              TextType.button,
              fontWeight: fontWeight,
              fontSize: fontSize,
              color: textColor,
            );

    final safeAction = (isEnabled && !isLoading) ? onPressed : null;

    // final child = AnimatedSwitcher(
    //   duration: const Duration(milliseconds: 300),
    //   switchInCurve: Curves.easeOut,
    //   switchOutCurve: Curves.easeIn,
    //   child: content,
    // );

    final child = AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      alignment: Alignment.center,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        layoutBuilder:
            (currentChild, previousChildren) => Stack(
              alignment: Alignment.center,
              children: [
                if (currentChild != null) currentChild,
                ...previousChildren,
              ],
            ),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(scale: animation, child: child),
          );
        },
        child: content,
      ),
    );

    if (type == ButtonType.filled) {
      return SizedBox(
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: borderRadius,
            boxShadow: shadow,
            border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
          ),
          child: FilledButton(
            onPressed: safeAction,
            style: FilledButton.styleFrom(
              backgroundColor: scheme.primary.withOpacity(0.9),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: borderRadius),
              textStyle: TextStyle(
                fontFamily: 'SFProText',
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
              elevation: 0,
            ),
            child: child,
          ),
        ),
      );
    }

    return TextButton(
      onPressed: safeAction,
      style: TextButton.styleFrom(
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        textStyle: TextStyle(
          fontFamily: 'SFProText',
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
      child: child,
    );
  }
}
