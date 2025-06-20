import 'package:firebase_with_riverpod/core/modules_shared/overlays/core/_context_x_for_overlays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../localization/app_localizer.dart';
import '../../localization/generated/locale_keys.g.dart';
import '../../localization/widgets/text_widget.dart';
import '../core/theme_type_enum.dart.dart';
import '../theme_provider/theme_config_provider.dart';

class ThemePicker extends ConsumerWidget {
  ///--------------------------------------
  const ThemePicker({super.key});
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final themeConfig = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);
    final locale = Localizations.localeOf(context);

    return DropdownButton<ThemeTypes>(
      key: ValueKey(locale.languageCode),
      value: themeConfig.theme,
      icon: const Icon(Icons.arrow_drop_down),
      underline: const SizedBox(),

      onChanged: (ThemeTypes? selected) {
        if (selected == null) return;

        // 🟢 Apply selected theme
        themeNotifier.setTheme(selected);

        // 🏷️ Fetch localized label
        final label = _chosenThemeLabel(context, selected);

        // 🌟 Show overlay banner with confirmation
        context.showUserBanner(message: label, icon: Icons.palette);
      },

      // 🧾 Theme options list
      items:
          [ThemeTypes.light, ThemeTypes.dark, ThemeTypes.amoled]
              .map(
                (type) => DropdownMenuItem<ThemeTypes>(
                  value: type,
                  child: TextWidget(
                    _themeLabel(context, type),
                    TextType.button,
                  ),
                ),
              )
              .toList(),
    );
  }

  //
  /// 🏷️ Returns localized label for a given theme type
  String _themeLabel(BuildContext context, ThemeTypes type) {
    switch (type) {
      case ThemeTypes.light:
        return AppLocalizer.t(LocaleKeys.theme_light);
      case ThemeTypes.dark:
        return AppLocalizer.t(LocaleKeys.theme_dark);
      case ThemeTypes.amoled:
        return AppLocalizer.t(LocaleKeys.theme_amoled);
    }
  }

  /// 🏷️ Returns localized label for a given theme type
  String _chosenThemeLabel(BuildContext context, ThemeTypes type) {
    switch (type) {
      case ThemeTypes.light:
        return AppLocalizer.t(LocaleKeys.theme_light_enabled);
      case ThemeTypes.dark:
        return AppLocalizer.t(LocaleKeys.theme_dark_enabled);
      case ThemeTypes.amoled:
        return AppLocalizer.t(LocaleKeys.theme_amoled_enabled);
    }
  }

  //
}
