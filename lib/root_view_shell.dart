import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart' show GoRouter;
import 'core/base_modules/localization/generated/locale_keys.g.dart';
import 'core/base_modules/navigation/core/provider_for_go_router.dart';
import 'core/base_modules/overlays/core/global_overlay_handler.dart';
import 'core/base_modules/theme/theme_providers_or_cubits/theme_provider.dart';

/// 🧩 [AppRootViewShell] — Combines both Theme and Router configuration
/// ✅ Ensures minimal rebuilds using selective `ref.watch(...)`
//
final class AppRootViewShell extends ConsumerWidget {
  ///------------------------------------------------
  const AppRootViewShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    // 🔀 Watch GoRouter only if instance changes
    final router = ref.watch(routerProvider.select((r) => r));

    // 🎯 Watch only theme
    final themeConfig = ref.watch(themeProvider.select((t) => t));

    // 🌓 Build modes and themes based on cached methods
    final lightTheme = themeConfig.buildLight();
    final darkTheme = themeConfig.buildDark();
    final themeMode = themeConfig.mode;

    return _AppRootView(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      router: router,
    );
  }
}

////

////

/// 📱🧱 [_AppRootView] — Final stateless [MaterialApp.router] widget.
/// ✅ Receives fully resolved config: theme + router + localization.
//
final class _AppRootView extends StatelessWidget {
  ///------------------------------------------
  //
  final ThemeData theme;
  final ThemeData darkTheme;
  final ThemeMode themeMode;
  final GoRouter router;

  const _AppRootView({
    required this.theme,
    required this.darkTheme,
    required this.themeMode,
    required this.router,
  });
  //

  @override
  Widget build(BuildContext context) {
    //
    return MaterialApp.router(
      title: LocaleKeys.app_title.tr(),
      debugShowCheckedModeBanner: !kReleaseMode,

      // 🌍 Localization config
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,

      // 🔀 GoRouter configuration
      routerConfig: router,

      /// 🎨 Theme configuration
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,

      // 🧩 Overlay system
      builder: (context, child) => GlobalOverlayHandler(child: child!),
    );
  }
}
