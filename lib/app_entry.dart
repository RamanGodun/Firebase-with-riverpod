import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/shared_modules/navigation/router_provider.dart';
import 'core/shared_modules/theme/config/app_material_theme.dart';
import 'core/shared_modules/theme/config/app_theme_config.dart';
import 'core/shared_modules/theme/provider_and_toggle_widget/theme_provider.dart';

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
    final config = AppConfig.fromMode(themeMode);

    return _MaterialRootWidget(router: router, config: config);
  }
}

/// 🧩 [_MaterialRootWidget] —  MaterialApp wrapper
class _MaterialRootWidget extends StatelessWidget {
  final GoRouter router;
  final AppThemeConfig config;
  const _MaterialRootWidget({required this.router, required this.config});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: config.title,
      debugShowCheckedModeBanner: config.debugShowCheckedModeBanner,

      /// 🌐 Localization
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,

      /// 🔁 Routing
      routerConfig: router,

      /// 🎨 Theming
      themeMode: config.themeMode,
      theme: config.theme,
      darkTheme: config.darkTheme,

      //
    );
  }
}
