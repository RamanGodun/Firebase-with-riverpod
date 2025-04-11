import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/bootstrap.dart';
import 'core/router/router.dart';
import 'core/config/loggers/observer_logger.dart';
import 'features/theme/app_theme.dart';
import 'features/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 🧰 Performs: platform checks (e.g. min Android SDK), [.env] file loading via [flutter_dotenv],
  /// remote and local storages initialization, applying of web-friendly URL strategy
  await bootstrapApp();

  /// 🚀 Launch the app with [ProviderScope] and custom [Logger]
  runApp(ProviderScope(observers: [Logger()], child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'FB with Riverpod',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppThemes.getLightTheme(),
      darkTheme: AppThemes.getDarkTheme(),
      themeMode: themeMode,
    );
  }
}
