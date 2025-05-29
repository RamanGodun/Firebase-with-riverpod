import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_entry.dart';
import 'core/app_config/bootstrap/bootstrap.dart';
import 'core/app_config/bootstrap/di_container.dart';
import 'core/shared_modules/localization/localization_config.dart';
import 'core/shared_modules/logging/riverpod_observer.dart';

Future<void> main() async {
  debugPrint('[Main] 🚀 App starting...');

  ///
  // 🔧 Perform all essential setup: Firebase, .env, local storage, etc.
  try {
    await AppBootstrap.initialize();
  } catch (e, s) {
    debugPrint('[Main][ERROR] ❌ Bootstrap failed: $e\n$s');
    rethrow;
  }

  debugPrint('[Main] ✅ Bootstrap completed. Launching app...');

  // 🚀🌐 Start the app within Riverpod's ProviderScope, custom logger and localization
  runApp(
    ProviderScope(
      overrides: diContainer,
      observers: [Logger()],
      child: AppLocalization.wrap(const RootAppWidget()),
    ),
  );
}

/*

flutter pub run build_runner build --delete-conflicting-outputs

*/
