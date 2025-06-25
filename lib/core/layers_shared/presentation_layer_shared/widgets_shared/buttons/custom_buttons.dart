import 'package:firebase_with_riverpod/core/modules_shared/theme/extensions/theme_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../modules_shared/localization/widgets/text_widget.dart';
import '../../../../modules_shared/theme/ui_constants/_app_constants.dart';
import '../../../../modules_shared/theme/ui_constants/app_colors.dart';

/// ✅ [CustomButton] — animated cross-platform button with Cupertino spinner and theming

class CustomButton extends StatelessWidget {
  ///--------------------------------------

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;

  final Color? foregroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.foregroundColor,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w400,
  });
  //

  @override
  Widget build(BuildContext context) {
    //
    final scheme = context.colorScheme;
    final isDark = context.isDarkMode;
    final borderRadius = UIConstants.commonBorderRadius;

    final backgroundColor = scheme.primary.withOpacity(0.9);

    /// 🎨 Text color based on type
    final textColor = AppColors.white;

    ///
    // final child = AnimatedSwitcher(
    //   duration: const Duration(milliseconds: 300),
    //   switchInCurve: Curves.easeOut,
    //   switchOutCurve: Curves.easeIn,
    //   child: content,
    // );

    /// 🔁 Animated label or Cupertino spinner
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
                  TextType.titleMedium,
                  fontWeight: fontWeight,
                  fontSize: fontSize,
                  color: textColor,
                ),
      ),
    );

    /// ⚙️ Only enabled when not loading
    final effectiveAction = (isEnabled && !isLoading) ? onPressed : null;

    /// 🧾 Button styling
    final style = FilledButton.styleFrom(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      padding: const EdgeInsets.symmetric(vertical: 16),
      elevation: 0,
      textStyle: TextStyle(
        fontFamily: 'SFProText',
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );

    /// 🔳 Filled variant — styled container with soft glass effect
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color:
              isDark
                  ? Colors.white.withOpacity(0.05)
                  : scheme.primary.withOpacity(0.08),
          borderRadius: borderRadius,
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
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
        ),
        child: FilledButton(
          onPressed: effectiveAction,
          style: style,
          child: buttonContent,
        ),
      ),
    );
  }

  //
}
