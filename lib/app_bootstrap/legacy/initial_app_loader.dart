import 'package:firebase_with_riverpod/core/foundation/localization/widgets/text_widget.dart';
import 'package:firebase_with_riverpod/core/foundation/theme/extensions/theme_x.dart';
import 'package:firebase_with_riverpod/core/layers_shared/presentation_layer_shared/widgets_shared/loaders/loader.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/foundation/theme/theme_provider/theme_config_provider.dart';

class ShellForInitialLoader extends ConsumerWidget {
  const ShellForInitialLoader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: !kReleaseMode,
      theme: themeState.buildLight(),
      darkTheme: themeState.buildDark(),
      themeMode: themeState.mode,
      home: const _InitialLoaderScreen(),
    );

    //
  }

  //
}

final class _InitialLoaderScreen extends StatelessWidget {
  const _InitialLoaderScreen();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppLoader(size: 38, strokeWidth: 3.2),
            SizedBox(height: 28),
            TextWidget('Loading…', TextType.titleMedium),
          ],
        ),
      ),
    );
  }
}

/*
Future<ThemeMode> resolveThemeMode() async {
  // await GetStorage.init();
  final storage = GetStorage();
  final isDark = storage.read('isDarkTheme') as bool?;

  final ThemeMode themeMode = switch (isDark) {
    true => ThemeMode.dark,
    false => ThemeMode.light,
    null =>
      WidgetsBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light,
  };
  return themeMode;
}

 */
