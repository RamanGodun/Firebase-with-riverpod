import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart' show GetStorage;
import '../../../../features/profile/data/profile_repo_impl.dart';
import '../../../../features/profile/data/profile_repo_provider.dart';
import '../../../../features/profile/data/remote_data_source.dart';
import '../../../foundation/navigation/core/go_router_provider.dart';
import '../../../foundation/overlays/overlays_dispatcher/_overlay_dispatcher.dart';
import '../../../foundation/overlays/overlays_dispatcher/overlay_dispatcher_provider.dart';
import '../../../foundation/theme/theme_provider/theme_config_provider.dart';

/// 🌍 Global singleton DI container
/// ✅ Used both inside the widget tree (`ProviderScope.parent`) and outside context
/// e.g., background logic, startup handlers, isolates, or tests).
/// ✅ Initialized once in [main()]

late final ProviderContainer globalContainer;

////
////
////

/// 📦 [diOverrides] — all DI overrides for Riverpod ProviderScope
/// 🧼 Used in `ProviderScope(overrides: diOverrides)` at app startup

final List<Override> diOverrides = [
  ///
  // 🧩 Profile
  profileRepoProvider.overrideWith(
    (ref) => ProfileRepoImpl(ProfileRemoteDataSourceImpl()),
  ),

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

  //
];

////

////

late final ProviderContainer dIContainerForInitLoader;

final List<Override> dIForLoaderOverrides = [
  ///
  // 🎨 Theme
  themeStorageProvider.overrideWith((ref) => GetStorage()),
  themeProvider.overrideWith(
    (ref) => ThemeConfigNotifier(ref.watch(themeStorageProvider)),
  ),
];
