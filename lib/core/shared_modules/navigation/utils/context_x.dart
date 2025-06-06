import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes_names.dart';

/// 🧭 [NavigationX] — Adds convenient navigation helpers
extension NavigationX on BuildContext {
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

  void popView() => Navigator.of(this).pop();

  Future<T?> pushTo<T>(Widget child) {
    return Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) => child));
  }
}
