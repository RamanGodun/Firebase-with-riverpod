import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart' show GoRouter;
import 'core/modules_shared/navigation/core/go_router.dart';
import 'core/modules_shared/theme/theme_config_provider/theme_config_provider.dart';
import 'root_view.dart';

/// 🌗🎨 [ThemeWrapper] — Provides reactive theme configuration to the app.
/// ✅ Watches [ThemeConfig] and passes [ThemeData] + [ThemeMode] to router layer.

final class ThemeWrapper extends ConsumerWidget {
  ///------------------------------------------
  const ThemeWrapper({super.key});
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final themeProvider = ref.watch(themeConfigProvider.select((t) => t));

    return RouterWrapper(
      theme: themeProvider.scheme.light,
      darkTheme: themeProvider.scheme.dark,
      themeMode: themeProvider.scheme.mode,
    );
  }
}

////

////

/// 🧭🔁 [RouterWrapper] — Provides reactive navigation configuration to the app.
/// ✅ Watches [GoRouter] and injects it into [MaterialApp.router].

final class RouterWrapper extends ConsumerWidget {
  ///-------------------------------------------

  final ThemeData theme;
  final ThemeData darkTheme;
  final ThemeMode themeMode;

  const RouterWrapper({
    required this.theme,
    required this.darkTheme,
    required this.themeMode,

    super.key,
  });
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final router = ref.watch(goRouter.select((r) => r));

    return AppRootView(
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      router: router,
    );
  }
}
