import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' show GoRouter;
import 'core/modules_shared/localization/generated/locale_keys.g.dart';
import 'core/modules_shared/overlays/core/global_overlay_handler.dart';

/// 📱🧱 [AppRootView] — Final stateless [MaterialApp.router] widget.
/// ✅ Receives fully resolved config: theme + router + localization.

final class AppRootView extends StatelessWidget {
  ///---------------------------------------

  final ThemeData theme;
  final ThemeData darkTheme;
  final ThemeMode themeMode;
  final GoRouter router;

  const AppRootView({
    super.key,
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
      title: LocaleKeys.app_title.tr(),
      debugShowCheckedModeBanner: false,

      // 🌍 Localization
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,

      // 🔀 Routing
      routerConfig: router,

      // 🎨 Theming
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,

      // 🧩 Overlay system
      builder: (context, child) => GlobalOverlayHandler(child: child!),
    );
  }
}
