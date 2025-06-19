import 'package:flutter/material.dart';

import 'app_themes.dart';
import 'enums.dart/_app_theme_type.dart.dart';
import '../theme_utils/theme_mode_adapter.dart';

/// 🎯 [AppThemeBuilder] — Unified config builder for both Bloc and Riverpod.
/// ✅ Converts either ThemeMode (Riverpod) or AppThemeState (Bloc) into AppThemeConfig.

@immutable
final class AppThemeBuilder {
  ///----------------------
  const AppThemeBuilder._();
  //

  /// 🧩 Factory from ThemeMode (used in Riverpod)
  static AppThemesScheme from(IAppThemeState state) {
    return AppThemesScheme(
      light: AppTheme.resolve(AppThemeType.light),
      dark: AppTheme.resolve(AppThemeType.dark),
      mode: state.mode,
    );
  }

  ///
  static AppThemesScheme fromType(AppThemeType type) {
    return AppThemesScheme.fromType(type);
  }

  /// 🧩 Fallback: default system mode
  static AppThemesScheme fallback() =>
      from(const ThemeModeAdapter(ThemeMode.system));

  //
}

////

////

/// 🎨 [AppThemesScheme] — Theme container passed into MaterialApp
/// ✅ Holds light/dark themes and current ThemeMode.

@immutable
final class AppThemesScheme {
  /// ─────----------------

  final ThemeData light;
  final ThemeData dark;
  final ThemeMode mode;

  const AppThemesScheme({
    required this.light,
    required this.dark,
    required this.mode,
  });
  //

  ///
  /// 🧩 Creates a full theme scheme from selected [AppThemeType]
  factory AppThemesScheme.fromType(AppThemeType type) {
    final isDark = switch (type) {
      AppThemeType.light => false,
      _ => true,
    };

    return AppThemesScheme(
      light: AppTheme.resolveFromType(AppThemeType.light),
      dark: AppTheme.resolveFromType(type),
      mode: isDark ? ThemeMode.dark : ThemeMode.light,
    );
  }

  //
}
