import 'package:firebase_with_riverpod/core/modules_shared/theme/extensions/theme_x.dart';
import 'package:flutter/material.dart';
import '../../../../modules_shared/localization/widgets/text_widget.dart';
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

    ///
    // final child = AnimatedSwitcher(
    //   duration: const Duration(milliseconds: 300),
    //   switchInCurve: Curves.easeOut,
    //   switchOutCurve: Curves.easeIn,
    //   child: content,
    // );

    return SizedBox(
      width: double.infinity,
      child: Hero(
        tag: 'submit',

        child: FilledButton(
          /// ⚙️ Only enabled when not loading
          onPressed: (isEnabled && !isLoading) ? onPressed : null,

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
                      ? AppLoader(
                        size: 20,
                        cupertinoRadius: 12,
                        color: scheme.onSurface,
                      )
                      : TextWidget(
                        label,
                        TextType.titleMedium,
                        fontWeight: fontWeight,
                        fontSize: fontSize,
                        color:
                            (isLoading || !isEnabled)
                                ? scheme.inverseSurface
                                : scheme.onPrimary,
                      ),
            ),
          ),
        ),
      ),
    );
  }

  //
}
