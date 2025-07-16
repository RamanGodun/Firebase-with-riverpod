import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart' show GetStorage;
import '../../core/base_modules/logging/for_riverpod/riverpod_observer.dart';
import '../../core/base_modules/navigation/core/go_router_provider.dart';
import '../../core/base_modules/overlays/overlays_dispatcher/_overlay_dispatcher.dart';
import '../../core/base_modules/overlays/overlays_dispatcher/overlay_dispatcher_provider.dart';
import '../../core/base_modules/theme/theme_provider/theme_config_provider.dart';
import '../../features/profile/data/profile_repo_impl.dart';
import '../../features/profile/data/profile_repo_provider.dart';
import '../../features/profile/data/remote_data_source.dart';

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
  @override
  List<Override> get overrides => [
    //
    // 🎨 Theme providers: Storage and ThemeConfig
    themeStorageProvider.overrideWith((ref) => GetStorage()),
    themeProvider.overrideWith(
      (ref) => ThemeConfigNotifier(ref.watch(themeStorageProvider)),
    ),

    /// 🗺️ Navigation: GoRouter
    goRouter.overrideWith((ref) => buildGoRouter(ref)),

    // 📤 Overlay dispatcher for modal overlays/toasts/dialogs
    overlayDispatcherProvider.overrideWith(
      (ref) => OverlayDispatcher(
        onOverlayStateChanged: ref.read(overlayStatusProvider.notifier).update,
      ),
    ),

    // 🧩 Profile repository with remote data source
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
