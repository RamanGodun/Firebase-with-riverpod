import 'package:flutter/material.dart';
import '../text_theme/text_theme_factory.dart';
import 'theme_type_enum.dart.dart';

/// 🎨 [ThemeConfig] — Lightweight configuration for theme and font
/// ✅ Contains only enums: [ThemeTypes] and [FontFamily]
/// 🚫 Does not hold ThemeData directly to prevent unnecessary rebuilds

@immutable
final class ThemeConfig with ThemeCacheMixin {
  /// Selected theme variant (light, dark, glass, amoled)
  final ThemeTypes theme;

  /// Selected font family (e.g., SF Pro, Aeonik)
  final FontFamily font;

  const ThemeConfig({required this.theme, required this.font});

  /// Creates a copy with updated fields
  ThemeConfig copyWith({ThemeTypes? theme, FontFamily? font}) {
    return ThemeConfig(theme: theme ?? this.theme, font: font ?? this.font);
  }

  /// Human-readable label (e.g. "glass · SFProText")
  String get label => '$theme · ${font.value}';

  /// Resolves [ThemeMode] based on current theme
  ThemeMode get mode => theme.isDark ? ThemeMode.dark : ThemeMode.light;

  /// Returns light [ThemeData] using cache
  ThemeData buildLight() => cachedTheme(ThemeTypes.light, font);

  /// Returns dark [ThemeData] using cache
  ThemeData buildDark() => cachedTheme(theme, font);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeConfig &&
          runtimeType == other.runtimeType &&
          theme == other.theme &&
          font == other.font;

  @override
  int get hashCode => Object.hash(theme, font);
}

////

////

/// 🧩 [ThemeCacheMixin] — Caches ThemeData by (ThemeTypes, FontFamily) pair

mixin ThemeCacheMixin {
  static final _cache = <(ThemeTypes, FontFamily), ThemeData>{};

  /// Returns cached [ThemeData] or builds and caches it if missing
  ThemeData cachedTheme(ThemeTypes theme, FontFamily font) {
    final key = (theme, font);
    return _cache.putIfAbsent(key, () => theme.buildTheme(font: font));
  }
}
