import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'start_up_bootstrap.dart';

/// 🧩 DI binding for startup logic
/// ✅ Provides [StartUpHandler] via global container
final startUpHandlerProvider = Provider<StartUpHandler>(
  (ref) => const DefaultStartUpHandler(),
);
