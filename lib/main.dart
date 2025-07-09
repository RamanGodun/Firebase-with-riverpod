import 'package:firebase_with_riverpod/wrapper_for_root_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/foundation/localization/app_localization.dart';
import 'core/layers_shared/presentation_layer_shared/pages_shared/bootstrap_screens/initial_app_loader.dart';
import 'core/layers_shared/_infrastructure_layer/di_container/di_container.dart';
import 'core/layers_shared/presentation_layer_shared/pages_shared/bootstrap_screens/critical_error_screen.dart';
import 'pre_bootstrap.dart';
import 'start_up_bootstrap.dart';

/// 🏁 Entry point of the application. Initializes Flutter bindings, configures DI, and launches the app
Future<void> main() async {
  ///
  final preBootstrap = AppPreBootstrap(
    // ? Here can be plugged in custom dependencies, e.g.:
    // debugTools: FakeDebugTools(),
  );
  // Run pre-bootstrap (storage, platform)
  await preBootstrap.run();

  // Init global DI container
  globalContainer = await preBootstrap.initDIContainer();

  ////

  /// 🏁🚀 Launches the app with ProviderScope using the global container as parent.
  runApp(
    ProviderScope(
      parent: globalContainer,
      child: const AppBootstrapper(),
      // AppLocalization.wrap(const AppRootViewWrapper()),
    ),
  );
}

////

class AppBootstrapper extends ConsumerWidget {
  const AppBootstrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final bootstrap = ref.watch(bootstrapProvider);

    return bootstrap.when(
      loading: () => const ShellForInitialLoader(),
      error: (err, stack) => const CriticalErrorScreen(),
      data: (_) => AppLocalization.wrap(const AppRootViewWrapper()),
    );
  }
}
