import 'package:flutter/material.dart';

// ===============================
// 📄 String Extensions
// ===============================

extension StringX on String {
  /// Capitalizes the first letter of a string
  String capitalize() =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}

extension StringValidationX on String {
  /// Validates if the string is a valid email format
  bool get isEmail =>
      RegExp(r"^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}\$").hasMatch(this);

  /// Validates if the string is a valid URL
  bool get isValidUrl => Uri.tryParse(this)?.hasAbsolutePath ?? false;

  /// Validates if the string is a valid phone number
  bool get isPhone => RegExp(r'^\+?[\d\s]{7,15}\$').hasMatch(this);
}

// ===============================
// 🎨 Theme/Text/Style Extensions
// ===============================

extension TextStyleX on TextStyle {
  /// Returns a new [TextStyle] with the specified weight
  TextStyle withWeight(FontWeight weight) => copyWith(fontWeight: weight);

  /// Returns a new [TextStyle] with the specified font size
  TextStyle withSize(double size) => copyWith(fontSize: size);
}

extension ThemeModeX on ThemeMode {
  /// Toggles between [ThemeMode.light] and [ThemeMode.dark]
  ThemeMode toggle() =>
      this == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
}



// ===============================
// 📦 Widget Extensions
// ===============================

extension WidgetPaddingX on Widget {
  /// Adds padding to all sides
  Widget paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  /// Adds symmetric padding horizontally & vertically
  Widget paddingSymmetric({double h = 0, double v = 0}) => Padding(
    padding: EdgeInsets.symmetric(horizontal: h, vertical: v),
    child: this,
  );
}

extension WidgetVisibilityX on Widget {
  /// Hides the widget if [shouldHide] is true
  Widget hide(bool shouldHide) => shouldHide ? const SizedBox.shrink() : this;
}

extension TapX on Widget {
  /// Wraps the widget with a [GestureDetector] for tap
  Widget onTap(VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: this,
  );
}

extension BorderRadiusX on Widget {
  /// Clips the widget with a rounded border
  Widget withRoundedCorners([double r = 12]) =>
      ClipRRect(borderRadius: BorderRadius.circular(r), child: this);
}

extension AnimateX on Widget {
  /// Animates opacity on the widget (fade-in effect)
  Widget fadeIn({Duration duration = const Duration(milliseconds: 400)}) {
    return AnimatedOpacity(opacity: 1, duration: duration, child: this);
  }
}

// ===============================
// 🧮 Num / Format Extensions
// ===============================

extension NumFormatX on num {
  /// Formats number as currency with optional symbol
  String toCurrency({String symbol = '₴'}) => '$symbol${toStringAsFixed(2)}';
}

// ===============================
// 🕓 Duration / DateTime Extensions
// ===============================

extension DurationX on Duration {
  /// Converts duration to mm:ss format string
  String formatAsTimer() {
    final mins = inMinutes.remainder(60).toString().padLeft(2, '0');
    final secs = inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }
}

// ========================================================= //
// 📅 DateTime Extensions
// ========================================================= //

extension DateTimeX on DateTime {
  /// Formats [DateTime] as a YYYY-MM-DD string
  String toFormatted([String format = 'yyyy-MM-dd']) =>
      '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
}
