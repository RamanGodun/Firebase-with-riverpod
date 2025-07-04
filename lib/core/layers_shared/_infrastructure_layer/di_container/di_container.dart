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
/// ✅ Used both inside the widget tree (`ProviderScope.parent`) and outside context (e.g., background logic, isolate, utilities)
/// ✅ Initialized once in [main()]

late final ProviderContainer globalContainer;

////
////
////

/// 📦 [diContainer] — global list of manually maintained providers
// 🧼 Used in `ProviderScope(overrides: [...])` or just imported once

final List<Override> diContainer = [
  //-------------------------------

  // 🧩 Profile layer
  profileRepoProvider.overrideWith(
    (ref) => ProfileRepoImpl(ProfileRemoteDataSourceImpl()),
  ),

  // 🎨 Theme layer
  themeStorageProvider.overrideWith((ref) => GetStorage()),
  themeProvider.overrideWith(
    (ref) => ThemeConfigNotifier(ref.watch(themeStorageProvider)),
  ),

  /// ── Navigation System ───
  goRouter.overrideWith((ref) => buildGoRouter(ref)),

  // 📤 Overlay dispatcher
  overlayDispatcherProvider.overrideWith(
    (ref) => OverlayDispatcher(
      onOverlayStateChanged: ref.read(overlayStatusProvider.notifier).update,
    ),
  ),

  // ...
];
