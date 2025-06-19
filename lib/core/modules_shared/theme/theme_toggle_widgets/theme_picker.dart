import 'package:firebase_with_riverpod/core/modules_shared/overlays/core/_context_x_for_overlays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../localization/app_localizer.dart';
import '../../localization/generated/locale_keys.g.dart';
import '../../localization/widgets/text_widget.dart';
import '../core/enums.dart/_app_theme_type.dart.dart';
import '../theme_provider/theme_provider.dart';

class ThemePicker extends ConsumerWidget {
  ///--------------------------------------
  const ThemePicker({super.key});
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final currentTheme = ref.watch(themeProvider);
    final locale = Localizations.localeOf(context);

    return DropdownButton<AppThemeType>(
      key: ValueKey(locale.languageCode),
      value: currentTheme,
      icon: const Icon(Icons.arrow_drop_down),
      underline: const SizedBox(),
      onChanged: (AppThemeType? selected) {
        if (selected == null) return;

        // 🟢 Apply selected theme
        ref.read(themeProvider.notifier).set(selected);

        // 🏷️ Fetch localized label
        final label = _chosenThemeLabel(context, selected);

        // 🌟 Show overlay banner with confirmation
        context.showUserBanner(message: label, icon: Icons.palette);
      },

      // 🧾 Theme options list
      items:
          [AppThemeType.light, AppThemeType.dark, AppThemeType.amoled]
              .map(
                (type) => DropdownMenuItem<AppThemeType>(
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
  String _themeLabel(BuildContext context, AppThemeType type) {
    switch (type) {
      case AppThemeType.light:
        return AppLocalizer.t(LocaleKeys.theme_light);
      case AppThemeType.dark:
        return AppLocalizer.t(LocaleKeys.theme_dark);
      case AppThemeType.amoled:
        return AppLocalizer.t(LocaleKeys.theme_amoled);
      default:
        return AppLocalizer.t(LocaleKeys.theme_dark);
    }
  }

  /// 🏷️ Returns localized label for a given theme type
  String _chosenThemeLabel(BuildContext context, AppThemeType type) {
    switch (type) {
      case AppThemeType.light:
        return AppLocalizer.t(LocaleKeys.theme_light_enabled);
      case AppThemeType.dark:
        return AppLocalizer.t(LocaleKeys.theme_dark_enabled);
      case AppThemeType.amoled:
        return AppLocalizer.t(LocaleKeys.theme_amoled_enabled);
      default:
        return AppLocalizer.t(LocaleKeys.theme_dark_enabled);
    }
  }

  //
}
