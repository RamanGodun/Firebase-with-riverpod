import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_core_initializations/debug_tools.dart';
import 'app_core_initializations/local_storage.dart';
import 'app_core_initializations/platform_validator.dart';
import 'di_container/di_container.dart';

/// 🏁 [IAppStartUp] — abstraction for minimal imperative startup logic.
///   - Orchestrates all required app-wide initializations before UI loads.
///   - Handles DI container setup for use both outside and inside the widget tree.

sealed class IAppStartUp {
  ///--------------------------------

  /// Runs all imperative pre-initialization (Flutter bindings, platform checks, debug flags, storage, etc).
  Future<void> run();

  /// Creates a global DI container accessible both outside and inside the widget tree.
  Future<void> initGlobalDIContainer();

  /// Initialize local storage
  Future<void> initLocalStorage();

  //
}

////

////

final class AppStartUp extends IAppStartUp {
  ///-----------------------------------------------------------------

  final IPlatformValidator _platformValidator;
  final IDebugTools _debugTools;
  final ILocalStorageStack _localStorageStack;
  // final IDiConfig _diConfig; // (Optional) advanced/test DI setup
  final DIConfiguration _diConfiguration;

  /// Creates a fully-configurable startup handler.
  /// All dependencies are injectable and default to production implementations if not provided.
  AppStartUp({
    IPlatformValidator? platformValidator,
    IDebugTools? debugTools,
    ILocalStorageStack? localStorageStack,
    DIConfiguration? diConfiguration,

    // IDiConfig? diConfig,
  }) : _platformValidator = platformValidator ?? const PlatformValidator(),
       _debugTools = debugTools ?? const DebugTools(),
       _localStorageStack = localStorageStack ?? const LocalStorageStack(),
       _diConfiguration = diConfiguration ?? InitialDIConfiguration()
  //  _diConfig = diConfig ?? const DefaultDiConfig(),
  ;

  ////

  @override
  Future<void> run() async {
    // Ensures Flutter bindings are ready before any further setup.
    WidgetsFlutterBinding.ensureInitialized();
    //
    // Validates platform (min. OS versions, emulator restrictions, etc).
    await _platformValidator.validatePlatformSupport();
    //
    // Configures Flutter debug tools/overlays.
    _debugTools.configure();
    //
  }

  ////

  @override
  Future<void> initGlobalDIContainer() async {
    //
    // Global DI for use both outside widget tree and for ProviderScope.parent
    //  ensuring shared DI and consistent overrides between imperative code and widgets tree.
    final ProviderContainer getGlobalContainer = ProviderContainer(
      overrides: _diConfiguration.overrides,
      //  [
      //   ///
      //   // 🎨 Theme
      //   themeStorageProvider.overrideWith((ref) => GetStorage()),
      //   themeProvider.overrideWith(
      //     (ref) => ThemeConfigNotifier(ref.watch(themeStorageProvider)),
      //   ),

      //   // 🗺️ Navigation
      //   goRouter.overrideWith((ref) => buildGoRouter(ref)),

      //   // 📤 Overlay dispatcher
      //   overlayDispatcherProvider.overrideWith(
      //     (ref) => OverlayDispatcher(
      //       onOverlayStateChanged:
      //           ref.read(overlayStatusProvider.notifier).update,
      //     ),
      //   ),

      //   // 🧩 Profile
      //   profileRepoProvider.overrideWith(
      //     (ref) => ProfileRepoImpl(ProfileRemoteDataSourceImpl()),
      //   ),
      //   //
      // ],
      // observers: [Logger()],
      observers: _diConfiguration.observers,
    );
    GlobalDIContainer.initialize(getGlobalContainer);
  }

  ////

  @override
  Future<void> initLocalStorage() async {
    // Initializes local storage (currently, GetStorage).
    await _localStorageStack.init();
  }

  //
}
