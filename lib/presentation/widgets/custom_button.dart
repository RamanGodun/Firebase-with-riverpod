import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/utils_and_services/extensions/context_extensions.dart';
import 'text_widget.dart';

enum ButtonType { filled, text }

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

    final backgroundColor = switch (type) {
      ButtonType.filled => scheme.primary.withOpacity(0.9),
      ButtonType.text => Colors.transparent,
    };

    final textColor = switch (type) {
      ButtonType.filled => Colors.white,
      ButtonType.text => foregroundColor ?? scheme.primary,
    };

    final buttonContent = AnimatedSize(
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
        transitionBuilder:
            (child, animation) => FadeTransition(
              opacity: animation,
              child: ScaleTransition(scale: animation, child: child),
            ),
        child:
            isLoading
                ? const CupertinoActivityIndicator(
                  radius: 12,
                  color: Colors.white,
                )
                : TextWidget(
                  label,
                  TextType.button,
                  fontWeight: fontWeight,
                  fontSize: fontSize,
                  color: textColor,
                ),
      ),
    );

    final effectiveAction = (isEnabled && !isLoading) ? onPressed : null;

    final style = switch (type) {
      ButtonType.filled => FilledButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: TextStyle(
          fontFamily: 'SFProText',
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        elevation: 0,
      ),
      ButtonType.text => TextButton.styleFrom(
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        textStyle: TextStyle(
          fontFamily: 'SFProText',
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    };

    if (type == ButtonType.filled) {
      return SizedBox(
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color:
                isDark
                    ? Colors.white.withOpacity(0.05)
                    : scheme.primary.withOpacity(0.08),
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                color:
                    isDark
                        ? Colors.black.withOpacity(0.2)
                        : Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
          ),
          child: FilledButton(
            onPressed: effectiveAction,
            style: style,
            child: buttonContent,
          ),
        ),
      );
    } else {
      return TextButton(
        onPressed: effectiveAction,
        style: style,
        child: buttonContent,
      );
    }
  }
}
