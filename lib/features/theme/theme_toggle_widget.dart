import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils_and_services/overlay/overlay_service.dart';
import '../../core/utils_and_services/extensions/context_extensions/_context_extensions.dart';
import 'theme_provider.dart';

/// 🌗 [ThemeToggleIcon] — toggles light/dark mode and shows overlay notification
class ThemeToggleIcon extends ConsumerWidget {
  const ThemeToggleIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    final icon =
        isDark ? AppConstants.darkModeIcon : AppConstants.lightModeIcon;
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
              isDark ? AppStrings.lightModeEnabled : AppStrings.darkModeEnabled,
          icon: isDark ? AppConstants.lightModeIcon : AppConstants.darkModeIcon,
        );
      },
    );
  }
}
