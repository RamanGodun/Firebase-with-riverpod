import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import '../core/_theme_config.dart';
import '../core/enums.dart/_app_theme_type.dart.dart';

part 'theme_storage_provider.dart';

/// 🧩 [themeConfigProvider] — StateNotifier for switching themes with injected storage
final themeConfigProvider =
    StateNotifierProvider<ThemeConfigNotifier, ThemeConfig>(
      (ref) => ThemeConfigNotifier(ref.watch(themeStorageProvider)),
    );

////

/// 🌗 [ThemeConfigNotifier] — Manages the ThemeMode state with persistent storage

class ThemeConfigNotifier extends StateNotifier<ThemeConfig> {
  ///------------------------------------------------------------

  final GetStorage _storage;
  static const _themeKey = 'selected_theme';
  static const _fontKey = 'selected_font';

  ThemeConfigNotifier(this._storage)
    : super(
        ThemeConfig(theme: _loadTheme(_storage), font: _loadFont(_storage)),
      );

  ///

  // 🧩 Load saved theme from storage
  static AppThemeType _loadTheme(GetStorage storage) {
    final stored = storage.read<String>(_themeKey);
    return AppThemeType.values.firstWhere(
      (e) => e.name == stored,
      orElse: () => AppThemeType.light,
    );
  }

  // 🔤 Load saved font
  static FontFamilyType _loadFont(GetStorage storage) {
    final stored = storage.read<String>(_fontKey);
    return FontFamilyType.values.firstWhere(
      (e) => e.name == stored,
      orElse: () => FontFamilyType.sfPro,
    );
  }

  // 🌓 Update theme only
  void setTheme(AppThemeType theme) {
    state = ThemeConfig(theme: theme, font: state.font);
    _storage.write(_themeKey, theme.name);
  }

  // 🔤 Update font only
  void setFont(FontFamilyType font) {
    state = ThemeConfig(theme: state.theme, font: font);
    _storage.write(_fontKey, font.name);
  }

  // 🧩 Update both at once
  void setThemeAndFont(AppThemeType theme, FontFamilyType font) {
    state = ThemeConfig(theme: theme, font: font);
    _storage.write(_themeKey, theme.name);
    _storage.write(_fontKey, font.name);
  }
}
