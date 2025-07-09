import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/foundation/logging/for_riverpod/riverpod_observer.dart';
import '../../core/foundation/navigation/core/go_router_provider.dart';
import '../../core/foundation/overlays/overlays_dispatcher/_overlay_dispatcher.dart';
import '../../core/foundation/overlays/overlays_dispatcher/overlay_dispatcher_provider.dart';
import '../../core/foundation/theme/theme_provider/theme_config_provider.dart';
import '../../features/profile/data/profile_repo_impl.dart';
import '../../features/profile/data/profile_repo_provider.dart';
import '../../features/profile/data/remote_data_source.dart';

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

////

////

////

sealed class DIConfiguration {
  ///
  List<Override> get overrides;

  ///
  List<ProviderObserver> get observers;
  //
}

////

////

final class InitialDIConfiguration implements DIConfiguration {
  @override
  List<Override> get overrides => [
    ///
    // 🎨 Theme
    themeStorageProvider.overrideWith((ref) => GetStorage()),
    themeProvider.overrideWith(
      (ref) => ThemeConfigNotifier(ref.watch(themeStorageProvider)),
    ),

    //
  ];

  ///
  @override
  List<ProviderObserver> get observers => [Logger()];

  //
}

////

final class FullDIConfiguration implements DIConfiguration {
  @override
  List<Override> get overrides => [
    ///
    // 🎨 Theme
    themeStorageProvider.overrideWith((ref) => GetStorage()),
    themeProvider.overrideWith(
      (ref) => ThemeConfigNotifier(ref.watch(themeStorageProvider)),
    ),

    // 🗺️ Navigation
    goRouter.overrideWith((ref) => buildGoRouter(ref)),

    // 📤 Overlay dispatcher
    overlayDispatcherProvider.overrideWith(
      (ref) => OverlayDispatcher(
        onOverlayStateChanged: ref.read(overlayStatusProvider.notifier).update,
      ),
    ),

    // 🧩 Profile
    profileRepoProvider.overrideWith(
      (ref) => ProfileRepoImpl(ProfileRemoteDataSourceImpl()),
    ),
    //
  ];

  ///
  @override
  List<ProviderObserver> get observers => [Logger()];

  //
}
