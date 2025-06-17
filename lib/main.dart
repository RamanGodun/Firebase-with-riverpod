import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'root_widget.dart';
import 'start_up_handler.dart';
import 'core/di_container/di_container.dart';
import 'core/modules_shared/localization/app_localization.dart';
import 'core/modules_shared/logging/for_riverpod/riverpod_observer.dart';

/// 🏁 Entry point of the application.
/// ✅ Performs synchronous bootstrapping and launches the app.

Future<void> main() async {
  ///
  // 🔧🧩 Essential services (Firebase, .env, secure storage, etc.)
  await StartUpHandler.bootstrap();

  // 🚀 Start the app within Riverpod's ProviderScope, custom logger and localization
  runApp(
    ProviderScope(
      parent: globalContainer,
      observers: [Logger()],
      child: AppLocalization.wrap(const AppRootShell()),
    ),
  );
}

/*
flutter pub run build_runner build --delete-conflicting-outputs
*/
