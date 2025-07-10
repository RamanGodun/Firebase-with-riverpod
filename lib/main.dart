import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_start_up/minimal_app_start_up.dart';
import 'app_start_up/di_container/di_container.dart';
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
  await startUp.initGlobalDIContainer();

  ////

  /// 🏁🚀 Launches the app with ProviderScope using the global container as parent.
  runApp(
    ProviderScope(
      parent: GlobalDIContainer.instance,
      child: const AppBootstrapper(),
    ),
  );
}

/*

Об’єднуй класи в один BootstrappingStack/Service, використовуй sealed “readiness state” і proxy DI, декларативний UI, error/retry flow

Централізований readiness state
	•	Для Riverpod ми робили StateNotifier/Provider, для BLoC/Cubit — просто Cubit з sealed states:
(	Ти додаєш цей Cubit в MultiBlocProvider, як і всі інші, або навіть реєструєш у GetIt.)



 */
