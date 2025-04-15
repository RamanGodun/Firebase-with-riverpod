import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/bootstrap.dart';
import 'core/config/loggers/observer_logger.dart';
import 'core/router/router.dart';
import 'features/theme/app_theme.dart';
import 'features/theme/theme_provider.dart';

Future<void> main() async {
  // 📦 Ensures all necessary bindings are ready before app initialization
  WidgetsFlutterBinding.ensureInitialized();

  // 🔧 Perform all essential setup: Firebase, .env, local storage, etc.
  await bootstrapApp();

  // 🚀 Start the app within Riverpod's ProviderScope and custom logger
  runApp(ProviderScope(observers: [Logger()], child: const RootWidget()));
}

/// 🌳 [RootWidget] defines the top-level widget that manages
/// global theming and routing using Riverpod & GoRouter
class RootWidget extends ConsumerWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'FB with Riverpod',
      debugShowCheckedModeBanner: false,
      // 📍 Dynamic routing
      routerConfig: router,
      // 🎨 Current theme mode
      themeMode: themeMode,
      theme: AppThemes.getLightTheme(),
      darkTheme: AppThemes.getDarkTheme(),
    );
  }
}
