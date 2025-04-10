import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utils_and_services/overlay/overlay_service.dart';
import 'theme_provider.dart';

class ThemeToggleIcon extends ConsumerWidget {
  const ThemeToggleIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    final icon =
        isDarkMode ? AppConstants.darkModeIcon : AppConstants.lightModeIcon;
    final iconColor = Theme.of(context).colorScheme.primary;

    return IconButton(
      icon: Icon(icon, color: iconColor),
      onPressed: () {
        ref.read(themeModeProvider.notifier).toggleTheme();

        OverlayNotificationService.showOverlay(
          context,
          message: isDarkMode ? 'Light mode enabled' : 'Dark mode enabled',
          icon:
              isDarkMode
                  ? AppConstants.lightModeIcon
                  : AppConstants.darkModeIcon,
        );
      },
    );
  }
}
