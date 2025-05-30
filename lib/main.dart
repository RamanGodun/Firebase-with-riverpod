import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show debugRepaintRainbowEnabled;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'root_widget.dart';
import 'start_up_handler.dart';
import 'core/di_container/di_container.dart';
import 'core/shared_modules/localization/app_localization.dart';
import 'core/shared_modules/logging/for_riverpod/riverpod_observer.dart';

/// 🏁 Entry point of the application.
/// ✅ Performs synchronous bootstrapping and launches the app.
Future<void> main() async {
  ///
  // 🔧🧩 Essential services (Firebase, .env, secure storage, etc.)
  await StartUpHandler.run();

  /// 🌈 Enables debug painting for layout visualization (repaint regions)
  debugRepaintRainbowEnabled = false;

  // 🚀 Start the app within Riverpod's ProviderScope, custom logger and localization
  runApp(
    ProviderScope(
      overrides: diContainer,
      observers: [Logger()],
      child: AppLocalization.wrap(const AppRootShell()),
    ),
  );
}

/*
flutter pub run build_runner build --delete-conflicting-outputs
*/
