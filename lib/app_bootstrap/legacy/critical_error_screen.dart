import 'package:firebase_with_riverpod/core/foundation/localization/widgets/text_widget.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:firebase_with_riverpod/core/foundation/theme/extensions/theme_x.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/foundation/theme/theme_provider/theme_config_provider.dart';

class ShellForCriticalErrorScreen extends ConsumerWidget {
  final Object error;

  const ShellForCriticalErrorScreen(this.error, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: !kReleaseMode,
      theme: themeState.buildLight(),
      darkTheme: themeState.buildDark(),
      themeMode: themeState.mode,
      home: _CriticalErrorScreen(error),
    );

    //
  }

  //
}

class _CriticalErrorScreen extends StatelessWidget {
  final Object error;
  const _CriticalErrorScreen(this.error);

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
              const TextWidget(
                'Oops! Something went wrong.',
                TextType.titleMedium,
              ),
              // TextWidget(error.toString(), TextType.titleMedium),
              const SizedBox(height: 14),
              const TextWidget(
                'Please restart the app or contact support if the problem persists.',
                TextType.bodySmall,
              ),
              const SizedBox(height: 34),
              FilledButton(
                onPressed: () {
                  // Ти можеш додати реальний restart або просто закрити/перезапустити app
                  // Для demo – просто navigator pop
                  Navigator.of(context).maybePop();
                },
                child: const TextWidget('Retry', TextType.button),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

