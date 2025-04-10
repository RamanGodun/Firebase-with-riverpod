import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/widgets/text_widget.dart';
import '../router/routes_names.dart';

/*
? maybe should separate to different utils and name them accordingly? */

/// 📦 [Helpers] — UI & navigation utility methods.
/// Includes shortcuts for:
///   • Navigation (goNamed, pushNamed)
///   • Theme & color accessors
///   • Common UI actions
class Helpers {
  // ===========================
  // 🔀 NAVIGATION HELPERS
  // ===========================

  /// 🔁 Go to a named route (replaces current route)
  static void goTo(
    BuildContext context,
    String routeName, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
  }) {
    try {
      GoRouter.of(context).goNamed(
        routeName,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
      );
    } catch (_) {
      GoRouter.of(context).go(RoutesNames.pageNotFound);
    }
  }

  /// ➕ Push a named route (adds to stack)
  static void pushToNamed(
    BuildContext context,
    String routeName, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
  }) {
    try {
      GoRouter.of(context).pushNamed(
        routeName,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
      );
    } catch (_) {
      GoRouter.of(context).go(RoutesNames.pageNotFound);
    }
  }

  /// ⬅️ Pops current route from stack
  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// 📦 Push a widget page via [MaterialPageRoute]
  static Future<T?> pushTo<T>(BuildContext context, Widget child) {
    return Navigator.of(
      context,
    ).push<T>(MaterialPageRoute(builder: (_) => child));
  }

  // ===========================
  // 🎨 THEME HELPERS
  // ===========================

  /// 🌙 Returns `true` if app is currently in dark mode
  static bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  /// 🎨 Returns current [ThemeData]
  static ThemeData getTheme(BuildContext context) => Theme.of(context);

  /// 🔤 Returns current [TextTheme]
  static TextTheme getTextTheme(BuildContext context) =>
      Theme.of(context).textTheme;

  /// 🎨 Returns current [ColorScheme]
  static ColorScheme getColorScheme(BuildContext context) =>
      Theme.of(context).colorScheme;

  /// ⛔ Removes focus from any input fields (closes keyboard)
  static void unfocus(BuildContext context) => FocusScope.of(context).unfocus();

  // ===========================
  // 🧩 Controllers helpers
  // ===========================
  static List<TextEditingController> createControllers(int count) {
    return List.generate(count, (index) => TextEditingController());
  }

  /// Disposes all controllers in the list
  static void disposeControllers(List<TextEditingController> controllers) {
    for (final controller in controllers) {
      controller.dispose();
    }
  }

  /// ===========================
  /// 🧩 FOR SNACKBAR
  // ===========================

  /// Shows a snackbar message
  static void showSnackbar(
    ScaffoldMessengerState scaffoldMessenger,
    String message,
  ) {
    scaffoldMessenger.showSnackBar(
      SnackBar(content: TextWidget(message, TextType.bodyMedium)),
    );
  }

  /// Add more specific helpers here if needed

  ///
}
