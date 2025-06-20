import 'package:firebase_with_riverpod/core/modules_shared/theme/core/theme_type_enum.dart.dart';
import 'package:flutter/material.dart' show ThemeData;
import '../text_theme/text_theme_factory.dart';

/// 🧩 [ThemeCacheMixin] — Caches ThemeData by (ThemeTypes, FontFamily) pair

mixin ThemeCacheMixin {
  static final _cache = <(ThemeTypes, FontFamily), ThemeData>{};

  /// Returns cached [ThemeData] or builds and caches it if missing
  ThemeData cachedTheme(ThemeTypes theme, FontFamily font) {
    final key = (theme, font);
    return _cache.putIfAbsent(key, () => theme.buildTheme(font: font));
  }
}
