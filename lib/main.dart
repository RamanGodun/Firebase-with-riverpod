import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/bootstrap/initialize_app.dart';
import 'core/shared_modules/logging/riverpod_observer.dart';
import 'core/shared_modules/navigation/router.dart';
import 'core/shared_modules/theme/app_theme.dart';
import 'core/shared_modules/theme/theme_provider.dart';

Future<void> main() async {
  // 📦 Ensures all necessary bindings are ready before app initialization
  WidgetsFlutterBinding.ensureInitialized();

  // 🔧 Perform all essential setup: Firebase, .env, local storage, etc.
  await initializeApp();

  // 🚀 Start the app within Riverpod's ProviderScope and custom logger
  runApp(ProviderScope(observers: [Logger()], child: const RootWidget()));
}

/// 🌳 [RootWidget] defines the top-level widget that manages global theming and routing
class RootWidget extends ConsumerWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'FB with Riverpod',
      debugShowCheckedModeBanner: false,
      // 📍 Dynamic routing with help of GoRouter
      routerConfig: router,
      // 🎨 Current theme mode
      themeMode: themeMode,
      theme: AppThemes.getLightTheme(),
      darkTheme: AppThemes.getDarkTheme(),
    );
  }
}
