import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../presentation/widgets/text_widget.dart';
import '../../router/routes_names.dart';

/// 🧠 [ContextX] — Adds expressive and concise extensions to [BuildContext].
extension ContextX on BuildContext {
  // ===============================
  // 🎨 THEME ACCESSORS
  // ===============================

  /// 🌙 Returns true if the current theme is dark.
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// 🎨 Shortcut for accessing [ThemeData].
  ThemeData get theme => Theme.of(this);

  /// 🧾 Shortcut for accessing [TextTheme].
  TextTheme get textTheme => theme.textTheme;

  /// 🌈 Shortcut for accessing [ColorScheme].
  ColorScheme get colorScheme => theme.colorScheme;

  // ===============================
  // ⌨️ KEYBOARD / FOCUS
  // ===============================

  /// ⛔ Removes focus from current focus node (closes keyboard).
  void unfocusKeyboard() => FocusScope.of(this).unfocus();

  // ===============================
  // 📏 MEDIAQUERY
  // ===============================

  /// 📐 Returns the current [MediaQueryData].
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// 📱 Returns true if the device is considered tablet-sized.
  bool get isTablet => mediaQuery.size.shortestSide >= 600;

  /// 📏 Screen width.
  double get screenWidth => mediaQuery.size.width;

  /// 📐 Screen height.
  double get screenHeight => mediaQuery.size.height;

  /// 🔠 Text scale factor.
  double get textScale => mediaQuery.textScaleFactor;

  /// 🔬 Device pixel ratio.
  double get pixelRatio => mediaQuery.devicePixelRatio;

  // ===============================
  // 📐 PADDING / INSETS
  // ===============================

  /// 🧱 Top safe area padding.
  double get topPadding => mediaQuery.padding.top;

  /// 🧱 Bottom safe area padding.
  double get bottomPadding => mediaQuery.padding.bottom;

  /// 🧱 Total horizontal padding (left + right).
  double get horizontalPadding =>
      mediaQuery.padding.left + mediaQuery.padding.right;

  /// 🧱 Total vertical padding (top + bottom).
  double get verticalPadding =>
      mediaQuery.padding.top + mediaQuery.padding.bottom;

  // ===============================
  // 📢 SNACKBAR
  // ===============================

  /// 📣 Shows a simple [SnackBar] with custom message.
  void showSnackbar(String message) {
    ScaffoldMessenger.of(
      this,
    ).showSnackBar(SnackBar(content: TextWidget(message, TextType.bodyLarge)));
  }
}

/// 🧭 [NavigationX] — Adds convenient navigation helpers to [BuildContext] for GoRouter.
extension NavigationX on BuildContext {
  /// 🔁 Navigates to a named route, replacing the current route.
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
      // If navigation fails, fallback to not-found route.
      GoRouter.of(this).go(RoutesNames.pageNotFound);
    }
  }

  /// ➕ Pushes a named route onto the navigation stack.
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

  /// ⬅️ Pops the current route.
  void popView() => Navigator.of(this).pop();

  /// 🧳 Pushes a widget as a [MaterialPageRoute].
  Future<T?> pushTo<T>(Widget child) {
    return Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) => child));
  }
}
