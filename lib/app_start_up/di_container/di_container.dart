import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 🌍 Global singleton DI container
/// ✅ Used both inside the widget tree (`ProviderScope.parent`) and outside context
/// e.g., background logic, startup handlers, isolates, or tests).
/// ✅ Initialized once in [main()]

final class GlobalDIContainer {
  ///-----------------------

  static ProviderContainer? _instance;
  static bool get isInitialized => _instance != null;

  static ProviderContainer get instance {
    if (_instance == null) {
      throw StateError('DIContainer.instance is not initialized!');
    }
    return _instance!;
  }

  static void initialize(ProviderContainer container) {
    if (_instance != null) {
      throw StateError('DIContainer.instance already initialized!');
    }
    _instance = container;
  }

  static void reset() => _instance = null; // for tests

  static Future<void> dispose() async {
    if (_instance != null) {
      _instance!.dispose();
      _instance = null;
    }
  }

  //
}
