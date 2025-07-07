import 'package:firebase_with_riverpod/root_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/layers_shared/_infrastructure_layer/di_container/di_container.dart';
import 'core/foundation/localization/app_localization.dart';
import 'start_up_bootstrap.dart';

/// 🏁 Entry point of the application. Initializes Flutter bindings, configures DI, and launches the app
Future<void> main() async {
  ///

  /// 🚀 Runs all imperative startup logic (localization, Firebase, storage, etc).
  /// StartupHandler can access DI from globalContainer outside context.
  final startUpHandler = const DefaultStartUpHandler(
    // ? Here can be plugged in custom dependencies, e.g.:
    // firebaseStack: MockFirebaseStack(),
    // debugTools: FakeDebugTools(),
  );
  await startUpHandler.bootstrap();

  ////

  /// 🏁🚀 Launches the app with ProviderScope using the global container as parent.
  runApp(
    ProviderScope(
      parent: globalContainer,
      child: AppLocalization.wrap(const AppRootViewWrapper()),
    ),
  );
}
