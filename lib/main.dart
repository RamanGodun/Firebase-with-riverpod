import 'package:firebase_with_riverpod/root_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_start_up/full_bootstrap_provider.dart';
import 'core/foundation/localization/app_localization.dart';
import 'app_start_up/bootstrap_screens/initial_app_loader.dart';
import 'app_start_up/di_container/di_container.dart';
import 'app_start_up/bootstrap_screens/critical_error_screen.dart';
import 'app_start_up/app_initial_start_up_handler.dart';

/// 🏁 Entry point of the application. Initializes Flutter bindings, configures DI, and launches the app
Future<void> main() async {
  ///
  final startUp = AppInitialStartUp(
    // ? Here can be plugged in custom dependencies, e.g.:
    // debugTools: FakeDebugTools(),
  );
  // Run imperative bootstrap (platform validation, debug tools configuration, local storage initialization)
  await startUp.run();

  // Init global DI container
  globalContainer = await startUp.initDIContainer();

  ////

  /// 🏁🚀 Launches the app with ProviderScope using the global container as parent.
  runApp(
    ProviderScope(parent: globalContainer, child: const AppBootstrapper()),
  );
}

////

class AppBootstrapper extends ConsumerWidget {
  const AppBootstrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    // Declarative dependence from
    final fullBootstrap = ref.watch(appFullStartUpProvider);

    return fullBootstrap.when(
      loading: () => const ShellForInitialLoader(),
      error: (err, stack) => const ShellForCriticalErrorScreen(),
      data: (_) => AppLocalization.wrap(const AppRootViewWrapper()),
    );
  }
}
