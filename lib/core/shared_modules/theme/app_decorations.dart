import 'package:flutter/material.dart'
    show
        Border,
        BorderRadius,
        BorderSide,
        BoxDecoration,
        BoxShadow,
        Offset,
        Radius;
import 'core/app_colors.dart';

/// 🎨 [BannerDecorations] — macOS/iOS-style banners with glassmorphism
/// 🍏 Includes blur, border, shadows for light/dark modes
/// ────────────────────────────────────────────────────────────────
final class BannerDecorations {
  const BannerDecorations._();

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

  static BoxDecoration glassBox(bool isDark) =>
      isDark ? glassBoxDark : glassBoxLight;
}

/// 🧊 [DialogDecorations] — iOS/macOS style dialogs with soft glass style
/// - Used in Cupertino alert modals
/// ────────────────────────────────────────────────────────────────
final class DialogDecorations {
  const DialogDecorations._();

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

  static BoxDecoration glassBox(bool isDark) => isDark ? dark : light;
}

/// 🧱 [AndroidDialogDecorations] — Material-style overlays (Dialog, Snackbar, Banner)
/// - Consistent Material 3 appearance
/// - Centralized styles for Android overlays
/// ────────────────────────────────────────────────────────────────
final class AndroidDialogDecorations {
  const AndroidDialogDecorations._();

  /// 🌙 Dialog for **dark mode**
  static const BoxDecoration dark = BoxDecoration(
    color: AppColors.darkSurface,
    borderRadius: BorderRadius.all(Radius.circular(12)),
    boxShadow: [
      BoxShadow(
        color: AppColors.androidDialogShadowDark,
        blurRadius: 14,
        spreadRadius: 0.2,
        offset: Offset(0, 4),
      ),
    ],
  );

  /// ☀️ Dialog for **light mode**
  static const BoxDecoration light = BoxDecoration(
    color: AppColors.lightSurface,
    borderRadius: BorderRadius.all(Radius.circular(12)),
    boxShadow: [
      BoxShadow(
        color: AppColors.androidDialogShadowLight,
        blurRadius: 10,
        spreadRadius: 0.1,
        offset: Offset(0, 3),
      ),
    ],
  );

  /// 🍞 Snackbar style (similar to dialog but with border)
  static BoxDecoration snackbar(bool isDark) => BoxDecoration(
    color: isDark ? AppColors.snackbarDark : AppColors.snackbarLight,
    borderRadius: BorderRadius.circular(6),
    border: Border.all(
      color:
          isDark
              ? AppColors.overlayDarkBorder.withOpacity(0.4)
              : AppColors.overlayLightBorder.withOpacity(0.5),
      width: 0.6,
    ),
  );

  /// 📦 Dialog decoration resolver
  static BoxDecoration resolve(bool isDark) => isDark ? dark : light;
}
