import 'package:firebase_with_riverpod/core/modules_shared/theme/extensions/theme_x.dart';
import 'package:flutter/material.dart';
import '../../../../modules_shared/localization/widgets/text_widget.dart';
import '../../../../modules_shared/theme/ui_constants/_app_constants.dart';
import '../../../../modules_shared/theme/ui_constants/app_colors.dart';
import '../loader.dart';

/// ✅ [CustomFilledButton] — animated cross-platform button with Cupertino spinner and theming

class CustomFilledButton extends StatelessWidget {
  ///--------------------------------------

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;

  final Color? foregroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CustomFilledButton({
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

    ///
    // final child = AnimatedSwitcher(
    //   duration: const Duration(milliseconds: 300),
    //   switchInCurve: Curves.easeOut,
    //   switchOutCurve: Curves.easeIn,
    //   child: content,
    // );

    /// 🔳 Filled variant — styled container with soft glass effect
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color:
              isDark
                  ? Colors.white.withOpacity(0.05)
                  : scheme.primary.withOpacity(0.08),
          borderRadius: UIConstants.commonBorderRadius,
          border: Border.all(color: AppColors.white.withOpacity(0.1), width: 1),
          boxShadow: [
            BoxShadow(
              color:
                  isDark
                      ? AppColors.black.withOpacity(0.2)
                      : AppColors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: Hero(
          tag: 'submit',
          child: FilledButton(
            /// ⚙️ Only enabled when not loading
            onPressed: (isEnabled && !isLoading) ? onPressed : null,
            style: FilledButton.styleFrom(
              backgroundColor: scheme.primary.withOpacity(0.8),
              shape: const RoundedRectangleBorder(
                borderRadius: UIConstants.commonBorderRadius,
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              elevation: AppSpacing.zero,
            ),

            child:
            /// 🔁 Animated label or Cupertino spinner
            AnimatedSize(
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
                        ? const AppLoader(
                          size: 20,
                          cupertinoRadius: 12,
                          color: AppColors.white,
                        )
                        : TextWidget(
                          label,
                          TextType.titleMedium,
                          fontWeight: fontWeight,
                          fontSize: fontSize,
                          color: scheme.onPrimary,
                        ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //
}
