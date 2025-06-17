import 'package:firebase_with_riverpod/core/modules_shared/localization/generated/locale_keys.g.dart';
import 'package:firebase_with_riverpod/core/modules_shared/overlays/core/_context_x_for_overlays.dart';
import 'package:firebase_with_riverpod/core/modules_shared/theme/extensions/theme_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/_app_constants.dart';
import '../localization/app_localizer.dart';
import 'theme_provider/theme_provider.dart';

/// 🌗 [ThemeToggleIcon] — toggles light/dark mode and shows overlay notification

class ThemeToggleIcon extends ConsumerWidget {
  const ThemeToggleIcon({super.key});
  //--------------------------------

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final wasDark = ref.watch(themeModeProvider) == ThemeMode.dark;

    final icon = wasDark ? AppIcons.lightMode : AppIcons.darkMode;
    final iconColor = context.colorScheme.primary;

    return IconButton(
      icon: Icon(icon, color: iconColor),

      onPressed: () {
        /// 🕹️🔄 Toggles the theme between light and dark mode.
        ref.read(themeModeProvider.notifier).toggleTheme();

        final msgKey =
            wasDark
                ? LocaleKeys.theme_light_enabled
                : LocaleKeys.theme_dark_enabled;
        final message = AppLocalizer.t(msgKey);

        // 🌟 Show overlay with correct message and icon
        context.showUserBanner(message: message, icon: icon);

        //
      },
    );
  }
}
