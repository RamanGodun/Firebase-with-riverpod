import 'package:firebase_with_riverpod/core/shared_modules/theme/extensions/theme_x.dart';
import 'package:flutter/material.dart';
import '../../../shared_modules/localization/code_base_for_both_options/text_widget.dart';
import '../../constants/_app_constants.dart';

/// 🔁🌐 [RedirectTextButton] a reusable text button, used for navigation or redirects.
final class RedirectTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final bool isDisabled;

  const RedirectTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isDisabled ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            child: Divider(thickness: 0.5, color: AppColors.caption),
          ),
          const SizedBox(width: AppSpacing.m),
          TextWidget(
            label,
            TextType.bodyMedium,
            color: context.colorScheme.primary,
          ),
          const SizedBox(width: AppSpacing.m),
          const Expanded(
            child: Divider(thickness: 0.5, color: AppColors.caption),
          ),
        ],
      ),
    );
  }
}
