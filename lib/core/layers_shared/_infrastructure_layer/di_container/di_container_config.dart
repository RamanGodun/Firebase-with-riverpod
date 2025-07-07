import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart' show GetStorage;
import '../../../../features/profile/data/profile_repo_impl.dart';
import '../../../../features/profile/data/profile_repo_provider.dart';
import '../../../../features/profile/data/remote_data_source.dart';
import '../../../foundation/navigation/core/go_router_provider.dart';
import '../../../foundation/overlays/overlays_dispatcher/_overlay_dispatcher.dart';
import '../../../foundation/overlays/overlays_dispatcher/overlay_dispatcher_provider.dart';
import '../../../foundation/theme/theme_provider/theme_config_provider.dart';

/// 🔧 [IDiConfig] — Abstraction for DI configuration

abstract interface class IDiConfig {
  ///----------------------------
  //
  Future<List<Override>> buildOverrides();
  //
}

////

////

/// 🔧 [DefaultDiConfig] — Production DI configuration

final class DefaultDiConfig implements IDiConfig {
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

////

////

final class TestDiConfig implements IDiConfig {
  const TestDiConfig();

  @override
  Future<List<Override>> buildOverrides() async {
    return [
      // profileRepoProvider.overrideWith((ref) => MockProfileRepo()),
      // Other test overrides...
    ];
  }
}
