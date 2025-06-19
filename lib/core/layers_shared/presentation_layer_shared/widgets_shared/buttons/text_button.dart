import 'package:firebase_with_riverpod/core/modules_shared/theme/extensions/theme_x.dart';
import 'package:flutter/material.dart';
import '../../../../modules_shared/localization/widgets/text_widget.dart';
import '../../../../modules_shared/theme/theme_styling/constants/_app_constants.dart';
import '../../../../modules_shared/theme/theme_styling/app_colors.dart';

/// 🔁🌐 [RedirectTextButton] a reusable text button, used for navigation or redirects.

final class RedirectTextButton extends StatelessWidget {
  ///--------------------------------------------------

  final VoidCallback? onPressed;
  final String label;
  final bool isDisabled;

  const RedirectTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isDisabled = false,
  });
  //

  @override
  Widget build(BuildContext context) {
    //
    return TextButton(
      onPressed: isDisabled ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            child: Divider(thickness: 0.5, color: AppColors.caption),
          ),
          const SizedBox(width: AppSpacing.xxxm),
          TextWidget(
            label,
            TextType.bodyMedium,
            color: context.colorScheme.primary,
          ),
          const SizedBox(width: AppSpacing.xxxm),
          const Expanded(
            child: Divider(thickness: 0.5, color: AppColors.caption),
          ),
        ],
      ),
    );
  }
}
