import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/shared_modules/navigation/router_provider.dart';
import 'core/shared_modules/theme/app_theme.dart';
import 'core/shared_modules/theme/theme_provider.dart';

/// 🌳 [RootAppWidget] defines the top-level widget that manages global theming and routing
class RootAppWidget extends StatelessWidget {
  const RootAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AppShell();
  }
}

/// 🧱 [_AppShell] — provides reactive dependencies from Riverpod
class _AppShell extends ConsumerWidget {
  const _AppShell();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);
    return _LocalizedMaterialApp(router: router, themeMode: themeMode);
  }
}

/// 🧩 [_LocalizedMaterialApp] —  MaterialApp wrapper
class _LocalizedMaterialApp extends StatelessWidget {
  final GoRouter router;
  final ThemeMode themeMode;

  const _LocalizedMaterialApp({required this.router, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FB with Riverpod',
      debugShowCheckedModeBanner: false,

      /// 🌐 Localization
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,

      /// 🔁 Routing
      routerConfig: router,

      /// 🎨 Theming
      themeMode: themeMode,
      theme: AppThemes.getLightTheme(),
      darkTheme: AppThemes.getDarkTheme(),

      //
    );
  }
}
