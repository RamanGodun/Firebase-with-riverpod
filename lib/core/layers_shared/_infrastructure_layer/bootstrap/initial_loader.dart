import 'package:firebase_with_riverpod/core/layers_shared/presentation_layer_shared/widgets_shared/loader.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../foundation/theme/theme_provider/theme_config_provider.dart';

// ///
// Future<ThemeMode> resolveThemeMode() async {
//   ///

//   ///
//   // await GetStorage.init();
//   final storage = GetStorage();

//   final isDark = storage.read('isDarkTheme') as bool?;

//   final ThemeMode themeMode = switch (isDark) {
//     true => ThemeMode.dark,
//     false => ThemeMode.light,
//     null =>
//       WidgetsBinding.instance.platformDispatcher.platformBrightness ==
//               Brightness.dark
//           ? ThemeMode.dark
//           : ThemeMode.light,
//   };
//   return themeMode;
// }

// ////

// ////

// final class InitialLoader extends StatelessWidget {
//   final ThemeMode themeMode;

//   const InitialLoader({super.key, required this.themeMode});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       themeMode: themeMode,
//       theme: ThemeData.light(),
//       darkTheme: ThemeData.dark(),
//       home: const Scaffold(
//         body: Center(child: CircularProgressIndicator.adaptive()),
//       ),
//     );
//   }
// }

/// 🧩 [LocalAppRootViewWrapper] — Combines both Theme and Router configuration
/// ✅ Ensures minimal rebuilds using selective `ref.watch(...)`

final class LocalAppRootViewWrapper extends ConsumerWidget {
  ///------------------------------------------------
  const LocalAppRootViewWrapper({super.key});
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    // 🎯 Watch only theme
    final themeConfig = ref.watch(themeProvider);

    // 🌓 Build modes and themes based on cached methods
    final lightTheme = themeConfig.buildLight();
    final darkTheme = themeConfig.buildDark();
    final themeMode = themeConfig.mode;

    return _AppRootView(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
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

  const _AppRootView({
    required this.theme,
    required this.darkTheme,
    required this.themeMode,
  });
  //

  @override
  Widget build(BuildContext context) {
    //
    return MaterialApp(
      //
      debugShowCheckedModeBanner: !kReleaseMode,

      /// 🎨 Theme configuration
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,

      home: const AppLoader(),
    );
  }
}
