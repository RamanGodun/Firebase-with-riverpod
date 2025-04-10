import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_strategy/url_strategy.dart' show setPathUrlStrategy;
import 'core/router/router.dart';
import 'core/config/loggers/observer_logger.dart';
import 'data/sources/remote/consts/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Removes the `#` from web URLs for cleaner routing.
  setPathUrlStrategy();

  /// 🧱 Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
