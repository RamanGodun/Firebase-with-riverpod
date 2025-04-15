import 'package:flutter/material.dart';

/// ======================================================
/// 🔤 String Extensions
/// ======================================================

extension StringX on String {
  /// 🔠 Capitalizes the first letter of the string
  String capitalize() =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}

/// ======================================================
/// 🎨 TextStyle / Theme Extensions
/// ======================================================

extension TextStyleX on TextStyle {
  /// ➕ Returns a copy with modified font weight
  TextStyle withWeight(FontWeight weight) => copyWith(fontWeight: weight);

  /// ➕ Returns a copy with modified font size
  TextStyle withSize(double size) => copyWith(fontSize: size);
}

extension ThemeModeX on ThemeMode {
  /// 🔁 Toggles between [ThemeMode.dark] and [ThemeMode.light]
  ThemeMode toggle() =>
      this == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
}

/// ======================================================
/// 📦 Widget Extensions — Padding
/// ======================================================

extension WidgetPaddingX on Widget {
  /// 🧱 Adds padding on all sides
  Widget withPaddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  /// 🧱 Adds symmetric padding
  Widget withPaddingSymmetric({double h = 0, double v = 0}) => Padding(
    padding: EdgeInsets.symmetric(horizontal: h, vertical: v),
    child: this,
  );

  /// 🧱 Adds custom padding to each side
  Widget withPaddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Padding(
    padding: EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    ),
    child: this,
  );

  /// ↔️ Adds horizontal-only padding
  Widget withPaddingHorizontal(double value) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: value), child: this);

  /// ↕️ Adds vertical-only padding
  Widget withPaddingVertical(double value) =>
      Padding(padding: EdgeInsets.symmetric(vertical: value), child: this);

  /// ⬆️ Adds only top padding
  Widget withPaddingTop(double value) =>
      Padding(padding: EdgeInsets.only(top: value), child: this);

  /// ⬇️ Adds only bottom padding
  Widget withPaddingBottom(double value) =>
      Padding(padding: EdgeInsets.only(bottom: value), child: this);

  /// ⬅️ Adds only left padding
  Widget withPaddingLeft(double value) =>
      Padding(padding: EdgeInsets.only(left: value), child: this);

  /// ➡️ Adds only right padding
  Widget withPaddingRight(double value) =>
      Padding(padding: EdgeInsets.only(right: value), child: this);
}

/// ======================================================
/// 🔒 Widget Extensions — Visibility & Interactivity
/// ======================================================

extension WidgetVisibilityX on Widget {
  /// 👻 Hides widget completely if [shouldHide] is true
  Widget hide(bool shouldHide) => shouldHide ? const SizedBox.shrink() : this;
}

extension TapX on Widget {
  /// 👆 Wraps the widget in [GestureDetector] with onTap handler
  Widget onTap(VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: this,
  );
}

extension BorderRadiusX on Widget {
  /// 🟦 Applies rounded corners using [ClipRRect]
  Widget withRoundedCorners([double r = 12]) =>
      ClipRRect(borderRadius: BorderRadius.circular(r), child: this);
}

/// ======================================================
/// 🌀 Widget Animation Extensions
/// ======================================================

extension AnimateX on Widget {
  /// 🫧 Fades in the widget using [AnimatedOpacity]
  Widget fadeIn({Duration duration = const Duration(milliseconds: 400)}) =>
      AnimatedOpacity(opacity: 1, duration: duration, child: this);
}

/// ======================================================
/// 💰 Number Formatting Extensions
/// ======================================================

extension NumFormatX on num {
  /// 💸 Formats number as currency (default ₴)
  String toCurrency({String symbol = '₴'}) => '$symbol${toStringAsFixed(2)}';
}

/// ======================================================
/// 🕓 Duration Extensions
/// ======================================================

extension DurationX on Duration {
  /// ⏱️ Converts duration to mm:ss format (e.g. 02:45)
  String formatAsTimer() {
    final mins = inMinutes.remainder(60).toString().padLeft(2, '0');
    final secs = inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }
}

/// ======================================================
/// 📅 DateTime Extensions
/// ======================================================

extension DateTimeX on DateTime {
  /// 📆 Formats DateTime as `yyyy-MM-dd`
  String toFormatted([String format = 'yyyy-MM-dd']) =>
      '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
}
