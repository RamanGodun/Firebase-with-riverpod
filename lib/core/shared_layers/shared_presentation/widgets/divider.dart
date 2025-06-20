import 'package:firebase_with_riverpod/core/shared_modules/theme/core/app_colors.dart';
import 'package:firebase_with_riverpod/core/shared_modules/theme/extensions/theme_x.dart';
import 'package:flutter/material.dart';

import '../../../shared_modules/theme/core/constants/_app_constants.dart'
    show AppSpacing;

/// 🧊 [GlassTileDivider] — Subtle glass-style divider between dialog content and buttons.
/// Used in dialogs with translucent backgrounds and blurred layers.
/// ────────────────────────────────────────────────────────────────
final class GlassTileDivider extends StatelessWidget {
  const GlassTileDivider({super.key});

  @override
  Widget build(BuildContext context) {
    //
    final isDark = context.isDarkMode;

    return Column(
      children: [
        const SizedBox(height: AppSpacing.xxxm),
        Container(
          width: double.infinity,
          height: 0.5,
          margin: const EdgeInsets.only(bottom: AppSpacing.xxs),
          color: isDark ? AppColors.dividerLightOpacity : AppColors.darkBorder,
        ),
        const SizedBox(height: AppSpacing.xxxs),
      ],
    );
  }
}
