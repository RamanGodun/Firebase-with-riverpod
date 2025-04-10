import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// **Provider Logger (Observer)**
///
/// This class acts as an observer for Riverpod providers, enabling logging
/// of provider lifecycle events. It logs when a provider:
/// - **is initialized** (`didAddProvider`)
/// - **is updated** (`didUpdateProvider`)
/// - **is disposed** (`didDisposeProvider`)
///
/// ✅ Uses `debugPrint` for logging in **debug mode only** (via `kDebugMode`).
/// ✅ Adds timestamps to logs for better traceability.
class Logger extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      debugPrint('''
      {
        "timestamp": "${DateTime.now()}",
        "provider": "${provider.name ?? provider.runtimeType} initialized",
        "value exposed": "$value"
      }
      ''');
    }
    super.didAddProvider(provider, value, container);
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      debugPrint('''
      {
        "timestamp": "${DateTime.now()}",
        "provider": "${provider.name ?? provider.runtimeType} disposed"
      }
      ''');
    }
    super.didDisposeProvider(provider, container);
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      debugPrint('''
      {
        "timestamp": "${DateTime.now()}",
        "provider": "${provider.name ?? provider.runtimeType} updated",
        "previous value": "$previousValue",
        "new value": "$newValue"
      }
      ''');
    }
    super.didUpdateProvider(provider, previousValue, newValue, container);
  }
}
