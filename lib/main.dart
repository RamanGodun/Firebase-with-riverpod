import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'root_widget.dart';
import 'core/app_config/bootstrap/bootstrap.dart';
import 'core/app_config/bootstrap/di_container.dart';
import 'core/shared_modules/localization/app_localization.dart';
import 'core/shared_modules/logging/riverpod_observer.dart';

/// 🏁 Entry point of the application.
/// Performs synchronous bootstrapping and launches the app.
Future<void> main() async {
  ///
  // 🔧🧩 Essential services (Firebase, .env, secure storage, etc.)
  await AppBootstrap.initialize();

  // 🚀 Start the app within Riverpod's ProviderScope, custom logger and localization
  runApp(
    ProviderScope(
      overrides: diContainer,
      observers: [Logger()],
      child: AppLocalization.wrap(const RootAppShell()),
    ),
  );
}

/*
flutter pub run build_runner build --delete-conflicting-outputs
*/
