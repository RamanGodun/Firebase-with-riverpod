import 'package:flutter/material.dart';
import '../core/enums.dart/_app_theme_type.dart.dart';
import '../text_theme/text_theme_factory.dart';

@immutable
final class AppThemeConfig {
  /// Обраний варіант теми
  final ThemeTypes theme;

  /// Обраний шрифт
  final FontFamily font;

  /// Автоматично обчислювана світла тема
  final ThemeData light;

  /// Автоматично обчислювана темна тема
  final ThemeData dark;

  /// ThemeMode (для MaterialApp)
  final ThemeMode mode;

  const AppThemeConfig._({
    required this.theme,
    required this.font,
    required this.light,
    required this.dark,
    required this.mode,
  });

  /// 🔧 Factory-конструктор
  factory AppThemeConfig({
    required ThemeTypes theme,
    required FontFamily font,
  }) {
    return AppThemeConfig._(
      theme: theme,
      font: font,
      light: ThemeTypes.light.buildTheme(font: font),
      dark: theme.buildTheme(font: font),
      mode: theme.isDark ? ThemeMode.dark : ThemeMode.light,
    );
  }

  /// 🔁 Копія з оновленням
  AppThemeConfig copyWith({ThemeTypes? theme, FontFamily? font}) {
    final t = theme ?? this.theme;
    final f = font ?? this.font;

    return AppThemeConfig(theme: t, font: f);
  }

  /// 🧩 Текстова назва (опціонально для UI/логів)
  String get label => '$theme · ${font.value}';
}
