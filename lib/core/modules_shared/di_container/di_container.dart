import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart' show GetStorage;
import '../../../features/profile/data/profile_repo_impl.dart';
import '../../../features/profile/data/profile_repo_provider.dart';
import '../../../features/profile/data/remote_data_source.dart';
import '../overlays/overlays_dispatcher/_overlay_dispatcher.dart';
import '../overlays/overlays_dispatcher/overlay_dispatcher_provider.dart';
import '../theme/theme_config_provider/theme_config_provider.dart';

/// 🌍 Global singleton DI container
// ✅ Used both inside the widget tree (`ProviderScope.parent`)
// ✅ And outside context (e.g., background logic, isolate, utilities)
// 🧩 Instantiated once during bootstrap: `StartUpHandler._initDI()`

late final ProviderContainer globalContainer;

////

/// 📦 [diContainer] — global list of manually maintained providers
// 🧼 Used in `ProviderScope(overrides: [...])` or just imported once
// 🔧 Centralized registration of manual providers for Domain and Data layers

final List<Override> diContainer = [
  //-------------------------------

  /// ── Profile Layer ───

  // Fetches and updates user profile data
  profileRepoProvider.overrideWith(
    (ref) => ProfileRepoImpl(ProfileRemoteDataSourceImpl()),
  ),

  /// ── Theme Management ───

  // Persists theme mode
  themeStorageProvider.overrideWith((ref) => GetStorage()),
  // Controls current theme mode
  themeConfigProvider.overrideWith(
    (ref) => ThemeConfigNotifier(ref.watch(themeStorageProvider)),
  ),

  /// ── Overlay System ───

  // Handles showing/hiding overlays
  overlayDispatcherProvider.overrideWith(
    (ref) => OverlayDispatcher(
      onOverlayStateChanged: ref.read(overlayStatusProvider.notifier).update,
    ),
  ),

  // ...
];
