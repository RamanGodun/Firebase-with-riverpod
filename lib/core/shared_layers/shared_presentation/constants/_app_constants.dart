import 'package:flutter/material.dart';

part 'app_colors.dart';
part 'app_spacing.dart';
part 'app_icons.dart';

/// 📦 [UIConstants] — centralized place for static constants used across the app.
abstract class UIConstants {
  const UIConstants._();

  ///
  /// ────────────────────────────────────────────────────────────────────
  /// * 📏 Common UI Constants
  // ────────────────────────────────────────────────────────────────────

  /// 🎯 Common border radius for UI elements (e.g. buttons, cards)
  static const BorderRadius commonBorderRadius = BorderRadius.all(
    Radius.circular(12),
  );

  /// * 🔳 size Factors
  static const double sizeF08 = 0.8;

  /// ────────────────────────────────────────────────────────────────────
  /// * 🔥 OTHER
  // ────────────────────────────────────────────────────────────────────

  ///
}
