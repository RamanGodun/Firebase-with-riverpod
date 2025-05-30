import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/app_configs/app_root_config.dart';

/// 🌳🧩 [AppRootShell] — Provides app-wide dependencies (theme, router, locale).
/// ✅ Now simplified using factory constructor in [AppRootConfig].
//------------------------------------------------------------
class AppRootShell extends ConsumerWidget {
  const AppRootShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final config = AppRootConfig.from(ref: ref, context: context);
    return _AppRootView(config: config);
    //
  }
}

/// 📱🧱 [_AppRootView] — Final MaterialApp.router widget
///   ✅ Configured from [AppRootConfig].
//------------------------------------------------------
class _AppRootView extends StatelessWidget {
  final AppRootConfig config;
  const _AppRootView({required this.config});

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
