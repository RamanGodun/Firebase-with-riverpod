// 📦 Core model: App-wide theme configuration (theme + font)
import 'package:flutter/material.dart' show ThemeData, ThemeMode;
import 'package:meta/meta.dart' show immutable;
import 'enums.dart/_app_theme_type.dart.dart';

@immutable
final class ThemeConfig {
  /// 🌗 Selected [AppThemeType] (light, dark, amoled, etc.)
  final AppThemeType theme;

  /// 🔤 Selected [FontFamilyType] (sfPro, Aeonik, etc.)
  final FontFamilyType font;

  const ThemeConfig({required this.theme, required this.font});

  /// 🎨 Builds the full [AppThemesScheme] using theme + font
  AppThemesScheme get scheme => AppThemesScheme.fromType(theme, font: font);
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

  // 🧩 Factory using selected ThemeType + Font
  factory AppThemesScheme.fromType(
    AppThemeType type, {
    required FontFamilyType font,
  }) {
    return AppThemesScheme(
      light: AppThemeType.light.buildTheme(font: font),
      dark: type.buildTheme(font: font),
      mode: type.isDark ? ThemeMode.dark : ThemeMode.light,
    );
  }

  //
}
