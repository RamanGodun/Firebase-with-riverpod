import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/bootstrap.dart';
import 'core/router/router.dart';
import 'core/config/loggers/observer_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 🧱 Initialize Firebase, HydratedStorage & BLoC Observer
  await bootstrapApp();

  /// 🚀 Launch the root app
  runApp(ProviderScope(observers: [Logger()], child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'FB with Riverpod',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
