import 'package:flutter/material.dart';

import '../shared_modules/theme/core/app_themes.dart';
import '../shared_modules/theme/core/theming_enums.dart';

/// 🎛️ [ThemeConfig] — Factory for constructing theming configuration.
/// ✅ Resolves light/dark theme based on the selected [ThemeMode].
@immutable
final class ThemeConfig {
  const ThemeConfig._();

  static AppThemeConfig from(ThemeMode mode) {
    return AppThemeConfig(
      theme: AppThemes.resolve(AppThemeType.light),
      darkTheme: AppThemes.resolve(AppThemeType.dark),
      themeMode: mode,
    );
  }
}

/// 🎨 [AppThemeConfig] — Container holding [ThemeData] for MaterialApp.
/// ✅ Used by root-level widgets to apply consistent theming.
@immutable
final class AppThemeConfig {
  final ThemeData theme;
  final ThemeData darkTheme;
  final ThemeMode themeMode;

  const AppThemeConfig({
    required this.theme,
    required this.darkTheme,
    required this.themeMode,
  });
}
