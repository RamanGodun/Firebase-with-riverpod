import 'package:firebase_with_riverpod/core/modules_shared/theme/extensions/theme_mode_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

part 'theme_storage_provider.dart';

// final appThemeTypeProvider =
//     StateNotifierProvider<AppThemeTypeNotifier, AppThemeType>(
//       (ref) => AppThemeTypeNotifier(ref.watch(themeStorageProvider)),
//     );

/// 🧩 [themeModeProvider] — StateNotifier for switching themes with injected storage
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(ref.watch(themeStorageProvider)),
);

/// 🌗 [ThemeModeNotifier] — Manages the ThemeMode state with persistent storage
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  final GetStorage _storage;

  ThemeModeNotifier(this._storage) : super(_loadInitialTheme(_storage));

  /// 💾 Loads saved theme or defaults to system
  static ThemeMode _loadInitialTheme(GetStorage storage) {
    final stored = storage.read<String>(_themeStorageKey);
    return switch (stored) {
      'dark' => ThemeMode.dark,
      'light' => ThemeMode.light,
      _ => ThemeMode.system,
    };
  }

  /// 🔁🎨 Toggles theme and persists it
  void toggleTheme() {
    state = state.toggle();
    _storage.write(_themeStorageKey, state.name);
  }

  //
}
