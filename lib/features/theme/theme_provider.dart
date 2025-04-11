import 'package:firebase_with_riverpod/core/utils_and_services/extensions/others.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

/// 💾 Local storage instance for persisting theme mode
final _storage = GetStorage();

/// 🧩 [themeModeProvider] — Provides current [ThemeMode] and toggles it
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(),
);

/// 🌗 [ThemeModeNotifier] — Manages current app [ThemeMode]
/// On toggle: updates Riverpod state, persists selected theme to local storage
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(_loadThemeFromStorage());

  /// 🗂 Load theme from local storage
  static ThemeMode _loadThemeFromStorage() {
    final saved = _storage.read<String>('selectedTheme');
    return switch (saved) {
      'dark' => ThemeMode.dark,
      'light' => ThemeMode.light,
      _ => ThemeMode.system,
    };
  }

  /// 🔁 Toggle between light & dark mode
  void toggleTheme() {
    state = state.toggle();
    _storage.write('selectedTheme', state.name);
  }

  ///
}
