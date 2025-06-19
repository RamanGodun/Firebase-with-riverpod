import 'package:flutter/material.dart';
import 'constants/_app_constants.dart';
import 'app_colors.dart';
import '../text_theme/_text_styles.dart';
import 'enums.dart/_app_theme_type.dart.dart';

part 'themes_factory.dart';

/// 🎨 [AppTheme] — Scalable theme generator for the app
/// Used to build [ThemeData] for MaterialApp based on:
/// - Selected [AppThemeType]
/// - Optional custom font (e.g. for dynamic switching)

abstract interface class AppTheme {
  ///------------------------------
  AppTheme._();

  /// 🧬 Resolves a complete [ThemeData] from a available theme type options
  static ThemeData resolve(AppThemeType type, {FontFamilyType? font}) =>
      _ThemeFactory(type).build(font: font);

  ///
  static ThemeData resolveFromType(AppThemeType type) {
    return switch (type) {
      AppThemeType.light => const _ThemeFactory(AppThemeType.light).build(),
      AppThemeType.dark => const _ThemeFactory(AppThemeType.dark).build(),
      AppThemeType.amoled => const _ThemeFactory(AppThemeType.amoled).build(),
      AppThemeType.glass => const _ThemeFactory(AppThemeType.glass).build(),
    };
  }

  /// 🧪 Previews light/dark theme (used in toggles or previews)
  ThemeData preview({bool isDark = false}) =>
      _ThemeFactory(isDark ? AppThemeType.dark : AppThemeType.light).build();

  //
}
