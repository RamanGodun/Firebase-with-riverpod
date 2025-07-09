import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_start_up/di_container/di_container.dart';
import 'app_start_up/app_start_up.dart';
import 'bootstrapper.dart';

/// 🏁 Entry point of the application. Initializes Flutter bindings, configures DI, and launches the app
Future<void> main() async {
  ///
  final startUp = AppStartUp(
    // ? Here can be plugged in custom dependencies, e.g.:
    // debugTools: NewDebugTools(),
    // localStorageStack: OtherLocalStorageStack(),
  );
  // Run imperative bootstrap (platform validation, debug tools configuration, local storage initialization)
  await startUp.run();
  await startUp.initLocalStorage();

  // Init global DI container
  globalContainer = await startUp.initDIContainer();

  ////

  /// 🏁🚀 Launches the app with ProviderScope using the global container as parent.
  runApp(
    ProviderScope(parent: globalContainer, child: const AppBootstrapper()),
  );
}
