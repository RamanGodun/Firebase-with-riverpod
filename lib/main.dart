import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/app_config/bootstrap/bootstrap.dart';
import 'core/app_config/bootstrap/di_container.dart';
import 'core/shared_modules/localization/localization_config.dart';
import 'core/shared_modules/logging/riverpod_observer.dart';

Future<void> main() async {
  ///
  // 🔧 Perform all essential setup: Firebase, .env, local storage, etc.
  await AppBootstrap.initialize();

  // 🚀🌐 Start the app within Riverpod's ProviderScope, custom logger and localization
  runApp(
    ProviderScope(
      overrides: diContainer,
      observers: [Logger()],
      child: AppLocalization.wrap(const RootWidget()),
    ),
  );
}

/*
flutter pub run build_runner build --delete-conflicting-outputs
 */
