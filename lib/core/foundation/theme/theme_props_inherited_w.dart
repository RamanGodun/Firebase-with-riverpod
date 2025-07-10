import 'package:flutter/material.dart';

/// InheritedWidget, щоб theme-пропи були доступні нижче через context.
///   ✅ Оптимізує rebuild тільки під теми.
class ThemeProps extends InheritedWidget {
  const ThemeProps({
    super.key,
    required this.theme,
    required this.darkTheme,
    required this.themeMode,
    required super.child,
  });

  final ThemeData theme;
  final ThemeData darkTheme;
  final ThemeMode themeMode;

  static ThemeProps of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ThemeProps>()!;

  @override
  bool updateShouldNotify(covariant ThemeProps oldWidget) =>
      theme != oldWidget.theme ||
      darkTheme != oldWidget.darkTheme ||
      themeMode != oldWidget.themeMode;
}
