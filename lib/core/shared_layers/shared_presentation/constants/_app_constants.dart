import 'package:flutter/material.dart';

part 'app_spacing.dart';
part 'app_icons.dart';

/// 📦 [UIConstants] — centralized place for static constants used across the app.
abstract class UIConstants {
  const UIConstants._();

  /// 🎯 Common border radius for UI elements (e.g. buttons, cards)
  static const BorderRadius bRadius13 = BorderRadius.all(Radius.circular(13));

  /// 🎯 Card paddings
  static const EdgeInsets cardPadding = EdgeInsets.symmetric(
    horizontal: AppSpacing.p16,
    vertical: AppSpacing.p10,
  );

  static const EdgeInsets cardPaddingV26 = EdgeInsets.symmetric(
    horizontal: AppSpacing.p26,
    vertical: AppSpacing.p10,
  );

  static const EdgeInsets zeroPadding = EdgeInsets.all(AppSpacing.zero);

  /// ───────────────────────────────────────────────────────────────────
  /// * Other constants...
}
