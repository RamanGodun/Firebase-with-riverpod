import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:firebase_with_riverpod/firebase_options.dart'
    show DefaultFirebaseOptions;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/config/loggers/observer_logger.dart'
    show Logger;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// 🚀 Launch the root app
  runApp(ProviderScope(observers: [Logger()], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: Text('Firebase with riverpod'))),
    );
  }
}
