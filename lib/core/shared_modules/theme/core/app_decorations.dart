import 'package:flutter/material.dart'
    show
        Border,
        BorderRadius,
        BorderSide,
        BoxDecoration,
        BoxShadow,
        Offset,
        Radius;
import '../app_colors.dart';

/// 🎨 [BannerDecorations] — Unified visual styles used across the app
/// 🍏 Includes macOS-style glass boxes
//----------------------------------------------------------------
final class BannerDecorations {
  const BannerDecorations._();

  /// 🍏 Glass box for **light theme**
  static const BoxDecoration glassBoxLight = BoxDecoration(
    color: AppColors.overlayLightBackground,
    borderRadius: BorderRadius.all(Radius.circular(14)),
    border: Border.fromBorderSide(
      BorderSide(color: AppColors.overlayLightBorder2, width: 1),
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.overlayLightShadow,
        blurRadius: 8,
        spreadRadius: 0.5,
        offset: Offset(0, 3),
      ),
    ],
  );

  /// 🍏 Glass box for **dark theme**
  static const BoxDecoration glassBoxDark = BoxDecoration(
    color: AppColors.overlayDarkBackground,
    borderRadius: BorderRadius.all(Radius.circular(14)),
    border: Border.fromBorderSide(
      BorderSide(color: AppColors.overlayDarkBorder, width: 1),
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.overlayDarkShadow,
        blurRadius: 18,
        spreadRadius: 0.5,
        offset: Offset(0, 3),
      ),
    ],
  );

  /// 📦 Getter to resolve current theme’s decoration
  static BoxDecoration glassBox(bool isDark) =>
      isDark ? glassBoxDark : glassBoxLight;

  //
}

///

///

/// 🧊 [DialogDecorations] — Decorations for Cupertino dialogs (iOS/macOS style)
/// - Soft glassmorphism for light/dark themes
/// - Used in CupertinoAlertDialog (e.g., IOSAppDialog)
/// ────────────────────────────────────────────────────────────────
final class DialogDecorations {
  const DialogDecorations._();

  /// 🌙 Dark dialog background
  static const BoxDecoration dark = BoxDecoration(
    color: AppColors.overlayDarkBackground,
    borderRadius: BorderRadius.all(Radius.circular(14)),
    border: Border.fromBorderSide(
      BorderSide(color: AppColors.overlayDarkBorder, width: 1),
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.overlayDarkShadow,
        blurRadius: 12,
        spreadRadius: 0.4,
        offset: Offset(0, 3),
      ),
    ],
  );

  /// ☀️ Light dialog background (optimized for readability and elegance)
  static const BoxDecoration light = BoxDecoration(
    color: AppColors.overlayLightBackground4,
    borderRadius: BorderRadius.all(Radius.circular(14)),
    border: Border.fromBorderSide(
      BorderSide(color: AppColors.overlayLightBorder, width: 1),
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.overlayLightShadow,
        blurRadius: 6,
        spreadRadius: 0.4,
        offset: Offset(0, 3),
      ),
    ],
  );

  /// 🔘 Resolved theme-based getter
  static BoxDecoration glassBox(bool isDark) => isDark ? dark : light;
}
