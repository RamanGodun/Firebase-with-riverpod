import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import '../core/_theme_config.dart';
import '../core/theme_type_enum.dart.dart';
import '../text_theme/text_theme_factory.dart';

part 'theme_storage_provider.dart';

/// 🧩 [themeProvider] — StateNotifier for switching themes with injected storage
final themeProvider = StateNotifierProvider<ThemeConfigNotifier, ThemeConfig>(
  ///
  (ref) => ThemeConfigNotifier(ref.watch(themeStorageProvider)),
  //
);

////

////

/// 🌗 [ThemeConfigNotifier] — Manages the ThemeMode state with persistent storage

class ThemeConfigNotifier extends StateNotifier<ThemeConfig> {
  ///----------------------------------------------------------

  final GetStorage _storage;
  static const _themeKey = 'selected_theme';
  static const _fontKey = 'selected_font';

  ThemeConfigNotifier(this._storage)
    : super(
        ThemeConfig(theme: _loadTheme(_storage), font: _loadFont(_storage)),
      );

  ///

  /// 🧩 Load saved theme from storage
  static ThemeTypes _loadTheme(GetStorage storage) {
    //
    final stored = storage.read<String>(_themeKey);
    return ThemeTypes.values.firstWhere(
      (e) => e.name == stored,
      orElse: () => ThemeTypes.light,
    );
  }

  /// 🔤 Load saved font
  static FontFamily _loadFont(GetStorage storage) {
    //
    final stored = storage.read<String>(_fontKey);
    return FontFamily.values.firstWhere(
      (e) => e.name == stored,
      orElse: () => FontFamily.sfPro,
    );
  }

  /// 🌓 Update theme only
  void setTheme(ThemeTypes theme) {
    //
    state = ThemeConfig(theme: theme, font: state.font);
    _storage.write(_themeKey, theme.name);
  }

  /// 🔤 Update font only
  void setFont(FontFamily font) {
    //
    state = ThemeConfig(theme: state.theme, font: font);
    _storage.write(_fontKey, font.name);
  }

  /// 🧩 Update both at once
  void setThemeAndFont(ThemeTypes theme, FontFamily font) {
    //
    state = ThemeConfig(theme: theme, font: font);
    _storage.write(_themeKey, theme.name);
    _storage.write(_fontKey, font.name);
  }

  //
}
