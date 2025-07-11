import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart' show GetStorage;
import '../../features/profile/data/profile_repo_impl.dart';
import '../../features/profile/data/profile_repo_provider.dart';
import '../../features/profile/data/remote_data_source.dart';
import '../../core/foundation/navigation/core/go_router_provider.dart';
import '../../core/foundation/overlays/overlays_dispatcher/_overlay_dispatcher.dart';
import '../../core/foundation/overlays/overlays_dispatcher/overlay_dispatcher_provider.dart';
import '../../core/foundation/theme/theme_provider/theme_config_provider.dart';

/// 🔧 [IDIConfigAsync] — Abstraction for DI configuration
///     Can be used if DI Container became big and managing/testing become complicated

abstract interface class IDIConfigAsync {
  ///----------------------------
  //
  Future<List<Override>> buildOverrides();
  //
}

////

////

/// 🔧 [DefaultDiConfig] — Production DI configuration

final class DefaultDiConfig implements IDIConfigAsync {
  ///------------------------------------------
  const DefaultDiConfig();

  @override
  Future<List<Override>> buildOverrides() async {
    // Import your existing diOverrides logic here
    return [
      // Profile
      profileRepoProvider.overrideWith(
        (ref) => ProfileRepoImpl(ProfileRemoteDataSourceImpl()),
      ),
      // Theme
      themeStorageProvider.overrideWith((ref) => GetStorage()),
      themeProvider.overrideWith(
        (ref) => ThemeConfigNotifier(ref.watch(themeStorageProvider)),
      ),
      // Navigation
      goRouter.overrideWith((ref) => buildGoRouter(ref)),
      // Overlay dispatcher
      overlayDispatcherProvider.overrideWith(
        (ref) => OverlayDispatcher(
          onOverlayStateChanged:
              ref.read(overlayStatusProvider.notifier).update,
        ),
      ),
    ];
  }
}
