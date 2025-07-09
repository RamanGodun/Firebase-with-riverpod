import 'package:firebase_with_riverpod/core/foundation/theme/extensions/theme_x.dart';
import 'package:firebase_with_riverpod/core/layers_shared/presentation_layer_shared/widgets_shared/loaders/loader.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../foundation/theme/theme_provider/theme_config_provider.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Якщо є logo/бренд, додай сюди
            // Image.asset('assets/logo.png', height: 68),
            // SizedBox(height: 32),
            const AppLoader(size: 38, strokeWidth: 3.2),
            const SizedBox(height: 28),
            Text(
              'Loading…',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: colorScheme.onBackground.withOpacity(0.5),
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
