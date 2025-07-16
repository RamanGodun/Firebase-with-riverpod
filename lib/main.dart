import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_bootstrap_and_config/app_bootstrap.dart';
import 'app_bootstrap_and_config/di_container/di_container.dart';
import 'core/base_modules/localization/app_localization.dart';
import 'root_view_shell.dart';

/// 🏁 Entry point of the application
Future<void> main() async {
  ///
  final appBootstrap = AppBootstrap(
    // ? Here can be plugged in custom dependencies (e.g.  "localStorage: IsarLocalStorage()," )
  );

  /// 🚀 Runs all imperative startup logic (localization, Firebase, local storage, DI container, etc).
  await appBootstrap.initAllServices();

  ////

  /// 🏁🚀 Launches the app with ProviderScope using the global container as parent.
  runApp(
    ProviderScope(
      parent: GlobalDIContainer.instance,
      child: const AppLocalizationShell(),
    ),
  );
}

////

////

/// 🧩 [AppLocalizationShell] — Wraps the app shell with all localization config.
///   ✅ Ensures the entire app tree is properly localized before rendering the root UI.

final class AppLocalizationShell extends StatelessWidget {
  ///----------------------------------------------
  const AppLocalizationShell({super.key});

  @override
  Widget build(BuildContext context) {
    //
    /// Injects localization context into the widget tree.
    /// Provides all supported locales and translation assets to [child].
    return AppLocalization.configure(const AppRootViewShell());
  }
}

/*


flutter pub run build_runner build --delete-conflicting-outputs



 */
