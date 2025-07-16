import 'package:firebase_with_riverpod/core/base_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../localization/app_localizer.dart';
import '../../../localization/generated/locale_keys.g.dart';
import '../../../localization/widgets/text_widget.dart';
import '../../app_theme_variants.dart';
import '../../theme_provider/theme_config_provider.dart';

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

    return DropdownButton<ThemeVariantsEnum>(
      key: ValueKey(locale.languageCode),
      value: themeConfig.theme,
      icon: const Icon(Icons.arrow_drop_down),
      underline: const SizedBox(),

      onChanged: (ThemeVariantsEnum? selected) {
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
          [
                ThemeVariantsEnum.light,
                ThemeVariantsEnum.dark,
                ThemeVariantsEnum.amoled,
              ]
              .map(
                (type) => DropdownMenuItem<ThemeVariantsEnum>(
                  value: type,
                  child: TextWidget(
                    _themeLabel(context, type),
                    TextType.titleSmall,
                  ),
                ),
              )
              .toList(),
    );
  }

  //
  /// 🏷️ Returns localized label for a given theme type
  String _themeLabel(BuildContext context, ThemeVariantsEnum type) {
    switch (type) {
      case ThemeVariantsEnum.light:
        return AppLocalizer.translateSafely(LocaleKeys.theme_light);
      case ThemeVariantsEnum.dark:
        return AppLocalizer.translateSafely(LocaleKeys.theme_dark);
      case ThemeVariantsEnum.amoled:
        return AppLocalizer.translateSafely(LocaleKeys.theme_amoled);
    }
  }

  /// 🏷️ Returns localized label for a given theme type
  String _chosenThemeLabel(BuildContext context, ThemeVariantsEnum type) {
    switch (type) {
      case ThemeVariantsEnum.light:
        return AppLocalizer.translateSafely(LocaleKeys.theme_light_enabled);
      case ThemeVariantsEnum.dark:
        return AppLocalizer.translateSafely(LocaleKeys.theme_dark_enabled);
      case ThemeVariantsEnum.amoled:
        return AppLocalizer.translateSafely(LocaleKeys.theme_amoled_enabled);
    }
  }

  //
}
