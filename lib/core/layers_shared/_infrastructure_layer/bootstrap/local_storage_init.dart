import 'package:flutter/foundation.dart' show debugPrint;
import 'package:get_storage/get_storage.dart' show GetStorage;

/// 💾 [ILocalStorageStack] — Abstraction for local storage initialization logic.
/// ✅ Used to decouple local storage startup logic and enable mocking in tests.

abstract interface class ILocalStorageStack {
  /// Initializes all local storage services
  Future<void> init();
}

////

////

/// 💾 [DefaultLocalStorageStack] — Implementation of [ILocalStorageStack].
/// ✅ Initializes GetStorage (local key-value DB).

final class DefaultLocalStorageStack implements ILocalStorageStack {
  ///----------------------------------------------------
  const DefaultLocalStorageStack();

  @override
  Future<void> init() async {
    //
    // Initializes GetStorage (local key-value storage).
    await GetStorage.init();
    debugPrint('💾 GetStorage initialized!');

    /// Initialize other storages (e.g., SharedPreferences) here if needed.
  }

  //
}
