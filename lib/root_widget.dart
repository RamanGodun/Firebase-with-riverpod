import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/app_config/configs/localization_config.dart';
import 'core/shared_modules/navigation/router_provider.dart';
import 'core/app_config/configs/app_root_config.dart';
import 'core/app_config/configs/theme_config.dart';
import 'core/shared_modules/theme/provider_and_toggle_widget/theme_provider.dart';

/// 🌳 [RootAppShell] — Provides app-wide dependencies (theme, router, locale).
/// Consumes Riverpod providers and builds final [MaterialApp].
//------------------------------------------------------------
class RootAppShell extends ConsumerWidget {
  const RootAppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final router = ref.watch(routerProvider);
    final localization = LocalizationConfig.fromContext(context);

    final config = AppRootConfig(
      theme: ThemeConfig.from(themeMode),
      localization: localization,
      router: router,
    );

    return _RootMaterialApp(config: config);
  }
}

/// 🧱 [_RootMaterialApp] — Final MaterialApp.router widget
/// configured from [AppRootConfig].
//------------------------------------------------------
class _RootMaterialApp extends StatelessWidget {
  final AppRootConfig config;
  const _RootMaterialApp({required this.config});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: config.localization.title,
      debugShowCheckedModeBanner: !kReleaseMode,

      // 🌍 Localization
      locale: config.localization.locale,
      supportedLocales: config.localization.supportedLocales,
      localizationsDelegates: config.localization.delegates,

      // 🔀 Routing
      routerConfig: config.router,

      // 🎨 Theming
      theme: config.theme.theme,
      darkTheme: config.theme.darkTheme,
      themeMode: config.theme.themeMode,
    );
  }
}
