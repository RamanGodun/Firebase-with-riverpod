import 'package:firebase_with_riverpod/core/foundation/localization/generated/locale_keys.g.dart';
import 'package:firebase_with_riverpod/core/foundation/overlays/core/_context_x_for_overlays.dart';
import 'package:firebase_with_riverpod/core/foundation/theme/extensions/theme_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../ui_constants/_app_constants.dart';
import '../../../localization/app_localizer.dart';
import '../../app_theme_variants.dart';
import '../../theme_provider/theme_config_provider.dart';

/// 🌗 [ThemeToggler] — toggles light/dark mode and shows overlay notification

class ThemeToggler extends ConsumerWidget {
  ///-----------------------------------------
  const ThemeToggler({super.key});
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final wasDark = ref.watch(themeProvider).theme == ThemeVariantsEnum.dark;
    final icon = wasDark ? AppIcons.lightMode : AppIcons.darkMode;
    final iconColor = context.colorScheme.primary;

    return IconButton(
      icon: Icon(icon, color: iconColor),

      onPressed: () {
        //
        final newTheme =
            wasDark ? ThemeVariantsEnum.light : ThemeVariantsEnum.dark;

        /// 🕹️🔄 Toggles the theme between light and dark mode.
        ref.read(themeProvider.notifier).setTheme(newTheme);

        final msgKey =
            wasDark
                ? LocaleKeys.theme_light_enabled
                : LocaleKeys.theme_dark_enabled;
        final message = AppLocalizer.translateSafely(msgKey);

        // 🌟 Show overlay with correct message and icon
        context.showUserBanner(message: message, icon: icon);

        //
      },
    );
  }
}
