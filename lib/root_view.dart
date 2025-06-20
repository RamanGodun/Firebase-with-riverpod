import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart' show GoRouter;
import 'core/modules_shared/localization/generated/locale_keys.g.dart';
import 'core/modules_shared/navigation/core/go_router.dart';
import 'core/modules_shared/overlays/core/global_overlay_handler.dart';
import 'core/modules_shared/theme/theme_config_provider/theme_config_provider.dart';

/// 🧩 [AppRootViewWrapper] — Combines both Theme and Router configuration
/// ✅ Ensures minimal rebuilds using selective `ref.watch(...)`

final class AppRootViewWrapper extends ConsumerWidget {
  ///------------------------------------------------
  const AppRootViewWrapper({super.key});
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final theme = ref.watch(themeConfigProvider); // 🌓 watches Theme changes
    final router = ref.watch(goRouter); // 🧭 watches GoRouter changes

    return AppRootView(
      theme: theme.light,
      darkTheme: theme.dark,
      themeMode: theme.mode,
      router: router,
    );
  }
}

////

////

/// 📱🧱 [AppRootView] — Final stateless [MaterialApp.router] widget.
/// ✅ Receives fully resolved config: theme + router + localization.

final class AppRootView extends StatelessWidget {
  ///------------------------------------------

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
