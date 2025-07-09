import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:firebase_with_riverpod/core/foundation/theme/extensions/theme_x.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/foundation/theme/theme_provider/theme_config_provider.dart';

class ShellForCriticalErrorScreen extends ConsumerWidget {
  const ShellForCriticalErrorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: !kReleaseMode,
      theme: themeState.buildLight(),
      darkTheme: themeState.buildDark(),
      themeMode: themeState.mode,
      home: const _CriticalErrorScreen(),
    );

    //
  }

  //
}

class _CriticalErrorScreen extends StatelessWidget {
  const _CriticalErrorScreen();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 54,
                color: colorScheme.error.withOpacity(0.8),
              ),
              const SizedBox(height: 28),
              Text(
                'Oops! Something went wrong.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onBackground,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Please restart the app or contact support if the problem persists.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: colorScheme.onBackground.withOpacity(0.58),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 34),
              FilledButton(
                onPressed: () {
                  // Ти можеш додати реальний restart або просто закрити/перезапустити app
                  // Для demo – просто navigator pop
                  Navigator.of(context).maybePop();
                },
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 38,
                    vertical: 13,
                  ),
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Retry',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
