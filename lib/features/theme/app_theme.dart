import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import 'text_styles.dart';

/// 🎨 [AppThemes] — Provides consistent light/dark themes across the app.
abstract class AppThemes {
  /// ☀️ Returns the full [ThemeData] for Light Mode
  static ThemeData getLightTheme() {
    return _buildTheme(
      isDark: false,
      backgroundColor: AppConstants.lightBackgroundColor,
      primaryColor: AppConstants.lightPrimaryColor,
      accentColor: AppConstants.lightAccentColor,
      surfaceColor: AppConstants.lightSurface,
      overlayColor: AppConstants.lightOverlay,
      borderColor: AppConstants.lightBorder,
      onPrimary: Colors.white,
      onSurface: Colors.black,
    );
  }

  /// 🌙 Returns the full [ThemeData] for Dark Mode
  static ThemeData getDarkTheme() {
    return _buildTheme(
      isDark: true,
      backgroundColor: AppConstants.darkBackgroundColor,
      primaryColor: AppConstants.darkPrimaryColor,
      accentColor: AppConstants.lightAccentColor,
      surfaceColor: AppConstants.darkSurface,
      overlayColor: AppConstants.darkOverlay,
      borderColor: AppConstants.darkBorder,
      onPrimary: Colors.white,
      onSurface: Colors.white,
    );
  }

  // ================================================================= //

  /// 🧱 Builds both light and dark themes based on parameters
  static ThemeData _buildTheme({
    required bool isDark,
    required Color backgroundColor,
    required Color primaryColor,
    required Color accentColor,
    required Color surfaceColor,
    required Color overlayColor,
    required Color borderColor,
    required Color onPrimary,
    required Color onSurface,
  }) {
    final brightness = isDark ? Brightness.dark : Brightness.light;

    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: backgroundColor,

      // 🎨 Color scheme for the theme
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primaryColor,
        secondary: accentColor,
        background: backgroundColor,
        surface: surfaceColor,
        onPrimary: onPrimary,
        onSecondary: onSurface,
        onBackground: onSurface,
        onSurface: onSurface,
        error: AppConstants.errorColor,
        onError: onPrimary,
      ),

      // 🧭 AppBar theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: onSurface,
        centerTitle: false,
        actionsIconTheme: IconThemeData(color: primaryColor),
        titleTextStyle: TextStyle(
          fontFamily: 'SFProText',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: onSurface,
        ),
      ),

      // ⬆️ Elevated buttons styling
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: onPrimary,
          shape: const RoundedRectangleBorder(
            borderRadius: AppConstants.commonBorderRadius,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          elevation: 0.5,
        ),
      ),

      // ✍️ Typography styles
      textTheme: TextStyles4ThisAppThemes.materialTextTheme(isDark),

      // 📦 Card styling (glassmorphism-inspired)
      cardTheme: CardTheme(
        color: overlayColor,
        shape: const RoundedRectangleBorder(
          borderRadius: AppConstants.commonBorderRadius,
        ),
        shadowColor: Colors.black.withOpacity(isDark ? 0.2 : 0.1),
        elevation: 5,
      ),
    );
  }
}
