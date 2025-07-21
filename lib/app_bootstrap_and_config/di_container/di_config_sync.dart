import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart' show GetStorage;
import '../../core/base_modules/logging/for_riverpod/riverpod_observer.dart';
import '../../core/base_modules/navigation/core/go_router_provider.dart';
import '../../core/base_modules/overlays/overlays_dispatcher/_overlay_dispatcher.dart';
import '../../core/base_modules/overlays/overlays_dispatcher/overlay_dispatcher_provider.dart';
import '../../core/base_modules/theme/theme_provider/theme_config_provider.dart';
import '../../features/profile/data/remote_database_impl.dart';
import '../../features/profile/data/repo_impl.dart';
import '../../features/profile/data/data_layer_providers.dart';

/// 🔧 [DIConfig] — Abstract contract for DI (Dependency Injection) configuration.
///     Provides lists of provider overrides and observers for Riverpod setup.
///     Useful for switching between different DI environments or for testing.
//
sealed class IDIConfig {
  //
  /// List of provider overrides for this configuration.
  List<Override> get overrides;
  //
  /// List of provider observers for this configuration.
  List<ProviderObserver> get observers;
}

////

////

/// 🛠️ [DIConfiguration] — Default DI configuration for the app.
///     Sets up storage, theme, navigation, overlays, and profile repo.
//
final class DIConfiguration extends IDIConfig {
  ///-------------------------------------------------
  //
  /// 🔁 Combined list of all feature overrides
  @override
  List<Override> get overrides => [...coreOverrides, ...profileOverrides];

  ///
  @override
  List<ProviderObserver> get observers => [Logger()];

  ///
  //───────── 🧩 FEATURE OVERRIDE MODULES ──────────────────
  //

  /// 🌐 Core system-wide overrides (e.g. theme, routing, overlays)
  List<Override> get coreOverrides => [
    /// 🎨 Theme storage and state
    themeStorageProvider.overrideWith((ref) => GetStorage()),
    themeProvider.overrideWith(
      (ref) => ThemeConfigNotifier(ref.watch(themeStorageProvider)),
    ),

    /// 🧭 Routing provider (GoRouter)
    goRouter.overrideWith((ref) => buildGoRouter(ref)),

    /// 📤 Overlay dispatcher for toasts/dialogs/etc.
    overlayDispatcherProvider.overrideWith(
      (ref) => OverlayDispatcher(
        onOverlayStateChanged: ref.read(overlayStatusProvider.notifier).update,
      ),
    ),
  ];

  /// 👤 Profile feature: profile loading with caching
  List<Override> get profileOverrides => [
    /// 🔌 Firestore-based remote user source
    profileRemoteDataSourceProvider.overrideWith(
      (ref) => ProfileRemoteDataSourceImpl(),
    ),

    /// 📦 Profile repo with cache + failure handling
    profileRepoProvider.overrideWith(
      (ref) => ProfileRepoImpl(ref.watch(profileRemoteDataSourceProvider)),
    ),
  ];

  //
}
