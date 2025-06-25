import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_with_riverpod/core/modules_shared/theme/extensions/theme_x.dart';
import '../../../../modules_shared/localization/widgets/text_widget.dart';

/// 🔘 [CustomTextButton] — minimal, animated text-only button with underline option
class CustomTextButton extends StatelessWidget {
  ///--------------------------------------

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final Color? foregroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CustomTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.foregroundColor,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return TextButton(
      onPressed: (isEnabled && !isLoading) ? onPressed : null,
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor ?? colorScheme.primary,
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        textStyle: TextStyle(
          fontFamily: 'SFProText',
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
      child: AnimatedSize(
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
                  ? const CupertinoActivityIndicator(radius: 10)
                  : TextWidget(
                    label,
                    TextType.titleMedium,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: foregroundColor ?? colorScheme.primary,
                    isUnderlined: true,
                  ),
        ),
      ),
    );
  }
}
