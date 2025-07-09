import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'full_start_up_handler.dart';

/// 🚀 Runs all declarative startup logic (localization, Firebase, storage, etc).
final appFullStartUpProvider = FutureProvider<void>((ref) async {
  ///
  /// StartupHandler can access DI from globalContainer outside context.
  final fullAppBootstrap = const AppFullStartUpHandler(
    // ? Here can be plugged in custom dependencies, e.g.:
    // firebaseStack: MockFirebaseStack(),
  );
  await fullAppBootstrap.bootstrap();
  //
});
