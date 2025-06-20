part of '_app_constants.dart';

abstract final class AppIcons {
  const AppIcons._();
  // ──────────────

  // 🌤 Theme & UI
  static const IconData sun = Icons.sunny;
  static const IconData lightMode = Icons.light_mode;
  static const IconData darkMode = Icons.dark_mode;
  static const IconData sync = Icons.sync;
  static const IconData changeCircle = Icons.change_circle;

  // 📤 UI Actions
  static const IconData remove = Icons.remove;
  static const IconData delete = Icons.delete_forever;

  // 👤 Profile / Auth
  static const IconData profile = Icons.account_circle;
  static const IconData logout = Icons.exit_to_app;
  static const IconData email = Icons.email;
  static const IconData name = Icons.account_box;
  static const IconData password = Icons.lock;
  static const IconData confirmPassword = Icons.lock_outline;

  // 🌐 Language toggle icons
  static const IconData languageEn = Icons.language;
  static const IconData languageUk = Icons.g_translate;
  static const IconData languagePl = Icons.language;
  static const IconData language = Icons.language;

  //
}

///

extension ThemeIconX on IconData {
  IconData get toggled =>
      this == AppIcons.darkMode ? AppIcons.lightMode : AppIcons.darkMode;
}
