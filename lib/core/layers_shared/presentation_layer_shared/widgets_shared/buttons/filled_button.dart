import 'package:firebase_with_riverpod/core/modules_shared/animation/widget_animation_x.dart';
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
    final colorScheme = context.colorScheme;

    return SizedBox(
      width: double.infinity,
      child: Hero(
        tag: 'filled_button',

        child: FilledButton(
          /// ⚙️ Only enabled when not loading
          onPressed: (isEnabled && !isLoading) ? onPressed : null,

          child:
              //
              (isLoading
                      ? AppLoader(
                        size: 20,
                        cupertinoRadius: 12,
                        color: colorScheme.onSurface,
                      )
                      : TextWidget(
                        label,
                        TextType.titleMedium,
                        fontWeight: fontWeight,
                        fontSize: fontSize,
                        color:
                            (isLoading || !isEnabled)
                                ? colorScheme.inverseSurface
                                : colorScheme.onPrimary,
                      ))
                  .withAnimatedSwitcherSize(),
        ),
      ),
      // ),
      // ),
    );
  }

  //
}
