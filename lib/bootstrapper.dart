import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_start_up/bootstrap_screens/critical_error_screen.dart';
import 'app_start_up/bootstrap_screens/initial_app_loader.dart';
import 'app_start_up/full_start_up_provider.dart';
import 'app_root_shell.dart';

/// 🧩 [AppBootstrapper] — Declarative app entrypoint widget.

class AppBootstrapper extends ConsumerWidget {
  ///--------------------------------------
  const AppBootstrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    // Watches the full startup FutureProvider (localization, Firebase, etc.)
    final fullBootstrap = ref.watch(appFullStartUpProvider);

    /// ✅ Switches UI state based on the full asynchronous startup process:
    return fullBootstrap.when(
      //
      // Shows custom loader during critical services initialization
      loading: () => const ShellForInitialLoader(),

      // Displays a critical error screen if startup fails
      error: (error, stackTrace) {
        debugPrint('Startup failed, error: $error stackTrace: $stackTrace');
        return ShellForCriticalErrorScreen(error);
      },

      // Run main app shell with localization when ready
      data: (_) => const AppLocalizationShell(),
      //
    );
  }
}
