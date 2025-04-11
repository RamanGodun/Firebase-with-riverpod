import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../presentation/widgets/text_widget.dart';
import '../../router/routes_names.dart';

/// 🧠 [BuildContext] extensions for cleaner, expressive UI code
extension ContextX on BuildContext {
  // ===========================
  // 🎨 THEME
  // ===========================

  /// 🌙 Returns `true` if app is currently in dark mode
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// 🎨 Returns current [ThemeData]
  ThemeData get theme => Theme.of(this);

  /// 🔤 Returns current [TextTheme]
  TextTheme get textTheme => theme.textTheme;

  /// 🎨 Returns current [ColorScheme]
  ColorScheme get colorScheme => theme.colorScheme;

  // ===========================
  // ⌨️ KEYBOARD / FOCUS
  // ===========================

  /// ⛔ Removes focus from any input field (closes keyboard)
  void unfocusKeyboard() => FocusScope.of(this).unfocus();

  // ===========================
  // 📏 MEDIA QUERY
  // ===========================

  /// 📐 Returns current [MediaQueryData]
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Returns true if screen is considered tablet-sized
  bool get isTablet => MediaQuery.of(this).size.shortestSide >= 600;

  /// 🔢 Returns screen width
  double get screenWidth => mediaQuery.size.width;

  /// 🔢 Returns screen height
  double get screenHeight => mediaQuery.size.height;

  /// 🔠 Returns text scale factor
  double get textScale => mediaQuery.textScaleFactor;

  /// 📱 Returns device pixel ratio
  double get pixelRatio => mediaQuery.devicePixelRatio;

  // ===========================
  // 📐 PADDING & INSETS
  // ===========================

  /// 🧱 Safe area top padding (e.g. notch)
  double get topPadding => mediaQuery.padding.top;

  /// 🧱 Safe area bottom padding (e.g. home bar)
  double get bottomPadding => mediaQuery.padding.bottom;

  /// 🧱 Horizontal padding (left + right)
  double get horizontalPadding =>
      mediaQuery.padding.left + mediaQuery.padding.right;

  /// 🧱 Vertical padding (top + bottom)
  double get verticalPadding =>
      mediaQuery.padding.top + mediaQuery.padding.bottom;

  // ===============================
  // 📱 SNACKBARS
  // ===============================

  /// Shows a SnackBar with the provided message
  void showSnackbar(String message) {
    ScaffoldMessenger.of(
      this,
    ).showSnackBar(SnackBar(content: TextWidget(message, TextType.bodyLarge)));
  }

  ///
}

// ===============================
// 📱 NAVIGATION & ROUTING
// ===============================

/// 🧭 [NavigationX] — Adds convenient navigation helpers to [BuildContext].
extension NavigationX on BuildContext {
  /// 🔁 Navigates to a named route (replaces current route).
  void goTo(
    String routeName, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
  }) {
    try {
      GoRouter.of(this).goNamed(
        routeName,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
      );
    } catch (_) {
      GoRouter.of(this).go(RoutesNames.pageNotFound);
    }
  }

  /// ➕ Pushes a named route (adds to stack).
  void pushToNamed(
    String routeName, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
  }) {
    try {
      GoRouter.of(this).pushNamed(
        routeName,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
      );
    } catch (_) {
      GoRouter.of(this).go(RoutesNames.pageNotFound);
    }
  }

  /// ⬅️ Pops the current route from the stack.
  void popView() => Navigator.of(this).pop();

  /// 📦 Pushes a widget as a route using [MaterialPageRoute].
  Future<T?> pushTo<T>(Widget child) {
    return Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) => child));
  }
}
