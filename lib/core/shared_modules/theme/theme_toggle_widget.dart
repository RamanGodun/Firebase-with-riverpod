import 'package:firebase_with_riverpod/core/shared_modules/localization/generated/locale_keys.g.dart';
import 'package:firebase_with_riverpod/core/shared_modules/theme/extensions/theme_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared_presentation/constants/_app_constants.dart';
import '../overlays/simple_overlay/overlay_service.dart';
import 'theme_provider.dart';

/// 🌗 [ThemeToggleIcon] — toggles light/dark mode and shows overlay notification
class ThemeToggleIcon extends ConsumerWidget {
  const ThemeToggleIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    final icon = isDark ? AppIcons.darkModeIcon : AppIcons.lightModeIcon;
    final iconColor = context.colorScheme.primary;

    return IconButton(
      icon: Icon(icon, color: iconColor),
      onPressed: () {
        // 🔄 Toggle the theme
        ref.read(themeModeProvider.notifier).toggleTheme();

        // 🧃 Show feedback to user
        OverlayNotificationService.showOverlay(
          context,
          message:
              isDark
                  ? LocaleKeys.theme_light_enabled
                  : LocaleKeys.theme_dark_enabled,
          icon: isDark ? AppIcons.lightModeIcon : AppIcons.darkModeIcon,
        );
      },
    );
  }
}
