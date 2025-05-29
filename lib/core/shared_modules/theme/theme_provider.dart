import 'package:firebase_with_riverpod/core/shared_modules/theme/extensions/theme_mode_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

// 🔐 Key for storing theme preference
const _themeStorageKey = 'selectedTheme';

/// 💾 Singleton instance of [GetStorage] for theme persistence
final _storage = GetStorage();

/// 🧩 [themeModeProvider] — Global provider for theme switching
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(),
);

/// 🌗 [ThemeModeNotifier] — StateNotifier that manages app theme mode
/// It loads from local storage and updates it on change.
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(_loadInitialTheme());

  /// 📦 Load saved theme mode or fallback to system
  static ThemeMode _loadInitialTheme() {
    final stored = _storage.read<String>(_themeStorageKey);
    return switch (stored) {
      'dark' => ThemeMode.dark,
      'light' => ThemeMode.light,
      _ => ThemeMode.system,
    };
  }

  /// 🔁 Toggles between light and dark modes, saves selection to local storage
  void toggleTheme() {
    state = state.toggle();
    _storage.write(_themeStorageKey, state.name);
  }
}
