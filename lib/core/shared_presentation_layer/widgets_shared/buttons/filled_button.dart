import 'package:firebase_with_riverpod/core/base_modules/animation/widget_animation_x.dart';
import 'package:firebase_with_riverpod/core/base_modules/theme/extensions/theme_x.dart';
import 'package:flutter/material.dart';
import '../../../base_modules/localization/widgets/text_widget.dart';
import '../loaders/loader.dart';

/// ✅ [CustomFilledButton] — animated cross-platform button with Cupertino spinner and theming
//
final class CustomFilledButton extends StatelessWidget {
  ///------------------------------------------
  //
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;

  const CustomFilledButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
  });

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
                        fontWeight:
                            !isEnabled ? FontWeight.w300 : FontWeight.w400,
                        fontSize: 18,
                        letterSpacing: 0.9,
                        color:
                            (isLoading || !isEnabled)
                                ? colorScheme.inverseSurface
                                : colorScheme.onPrimary,
                      ))
                  .withAnimatedSwitcherSize(),
        ),
      ),
    );
  }

  //
}
