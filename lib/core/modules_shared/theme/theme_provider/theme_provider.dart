import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import '../core/enums.dart/_app_theme_type.dart.dart';

part 'theme_storage_provider.dart';

/// 🧩 [themeProvider] — StateNotifier for switching themes with injected storage
final themeProvider = StateNotifierProvider<ThemeTypeNotifier, AppThemeType>(
  (ref) => ThemeTypeNotifier(ref.watch(themeStorageProvider)),
);

////

/// 🌗 [ThemeModeNotifier] — Manages the ThemeMode state with persistent storage

class ThemeTypeNotifier extends StateNotifier<AppThemeType> {
  ///------------------------------------------------------------

  final GetStorage _storage;
  static const _key = 'selected_theme';

  ThemeTypeNotifier(this._storage) : super(_loadInitial(_storage));
  //

  /// 💾 Loads saved theme or defaults to system
  static AppThemeType _loadInitial(GetStorage storage) {
    final stored = storage.read<String>(_key);
    return AppThemeType.values.firstWhere(
      (e) => e.name == stored,
      orElse: () => AppThemeType.light,
    );
  }

  /// 🔁🎨 Set theme and persists it
  void set(AppThemeType type) {
    state = type;
    _storage.write(_key, type.name);
  }

  //
}

/// 🧩 [themeStorageProvider] — Provides the shared GetStorage instance
final themeStorageProvider = Provider<GetStorage>((ref) => GetStorage());
