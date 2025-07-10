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


/*

! From new methodology:

class AppErrorScreen extends ConsumerWidget {
  const AppErrorScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readinessState = ref.watch(appReadinessNotifierProvider);
    
    if (readinessState is! AppError) {
      return const SizedBox.shrink();
    }
    
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 24),
              
              Text(
                'Oops! Something went wrong',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              Text(
                readinessState.message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 24),
              
              if (readinessState.canRetry) ...[
                ElevatedButton.icon(
                  onPressed: () {
                    ref.read(appReadinessNotifierProvider.notifier).retry();
                    _initializeAppAsync(ProviderScope.containerOf(context));
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Try Again'),
                ),
                
                const SizedBox(height: 12),
                
                TextButton(
                  onPressed: () {
                    // Show detailed error information
                    _showErrorDetails(context, readinessState);
                  },
                  child: const Text('Show Details'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
  
  void _showErrorDetails(BuildContext context, AppError error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Message: ${error.message}'),
              if (error.error != null) ...[
                const SizedBox(height: 8),
                Text('Error: ${error.error}'),
              ],
              if (error.stackTrace != null) ...[
                const SizedBox(height: 8),
                Text('Stack Trace:\n${error.stackTrace}'),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}



 */