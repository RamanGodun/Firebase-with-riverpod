part of 'theme_provider.dart';

/// 🔐 Key for storing theme preference
const _themeStorageKey = 'selectedTheme';

/// 🧩 [themeStorageProvider] — Provides the shared GetStorage instance
final themeStorageProvider = Provider<GetStorage>((ref) => GetStorage());
