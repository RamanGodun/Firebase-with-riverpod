import 'package:firebase_with_riverpod/root_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/layers_shared/_infrastructure_layer/di_container/di_container.dart';
import 'core/foundation/localization/app_localization.dart';
import 'core/foundation/logging/for_riverpod/riverpod_observer.dart';
import 'start_up_bootstrap.dart';

/// 🏁 Entry point of the application.
/// ✅ Performs synchronous bootstrapping and launches the app.
Future<void> main() async {
  ///
  // 🛠️ Ensure Flutter is ready
  WidgetsFlutterBinding.ensureInitialized();

  /// Launch Loader, while app is initializing
  // final themeMode = await resolveThemeMode();
  // runApp(InitialLoader(themeMode: themeMode));

  /// 🧩 Create global ProviderContainer with overrides
  globalContainer = ProviderContainer(
    overrides: diContainer,
    observers: [Logger()],
  );

  /// 🚀 Run startup logic injected via DI
  final startUpHandler = const DefaultStartUpHandler(
    // ? Here can be pluged in custom dependencies, fe:
    // firebaseStack: MockFirebaseStack(),
    // debugTools: FakeDebugTools(),
  );
  await startUpHandler.bootstrap();

  ////

  // 🏁🚀 Run app inside Riverpod's scope with logger and localization
  runApp(
    ProviderScope(
      parent: globalContainer,
      child: AppLocalization.wrap(const AppRootViewWrapper()),
    ),
  );
}

/*

3.  Можна за бажанням кешувати GoRouter у Provider.autoDispose з keepAlive для тестабельності

4. Розглянь titleBuilder або реактивну зміну title, якщо локалізація зміниться на гарячу

 */
