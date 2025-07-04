import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart' show GoRouter;
// import 'core/modules_shared/localization/generated/locale_keys.g.dart';
import 'core/foundation/navigation/core/go_router_provider.dart';
import 'core/foundation/overlays/core/global_overlay_handler.dart';
import 'core/foundation/theme/theme_provider/theme_config_provider.dart';

/// 🧩 [AppRootViewWrapper] — Combines both Theme and Router configuration
/// ✅ Ensures minimal rebuilds using selective `ref.watch(...)`

final class AppRootViewWrapper extends ConsumerWidget {
  ///------------------------------------------------
  const AppRootViewWrapper({super.key});
  //

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

final class _AppRootView extends StatelessWidget {
  ///------------------------------------------

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
      //
      title: '',
      // titleBuilder: (context, _) => LocaleKeys.app_title.tr(),
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
