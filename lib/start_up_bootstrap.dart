import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/foundation/logging/for_riverpod/riverpod_observer.dart';
import 'core/layers_shared/_infrastructure_layer/bootstrap/debug_tools.dart';
import 'core/layers_shared/_infrastructure_layer/bootstrap/firebase_init.dart';
import 'core/layers_shared/_infrastructure_layer/bootstrap/local_storage_init.dart';
import 'core/layers_shared/_infrastructure_layer/bootstrap/localization_init.dart';
import 'core/layers_shared/_infrastructure_layer/bootstrap/others_bootstrap.dart';
import 'core/layers_shared/_infrastructure_layer/di_container/di_container.dart';
import 'core/layers_shared/_infrastructure_layer/di_container/di_container_config.dart';
import 'core/layers_shared/_infrastructure_layer/bootstrap/initial_loader.dart';

/// 🧰 [StartUpHandler] — Abstract contract for app startup logic

sealed class IStartUpHandler {
  ///----------------------------------
  const IStartUpHandler();
  //
  /// 🚀 Pre-initialization: Flutter bindings + splash loader + DI container
  Future<void> preBootstrap();

  /// 🚀 Main initialization: all services and dependencies
  Future<void> bootstrap();
  //
}

////

////

/// 🧰 [DefaultStartUpHandler] — Production [StartUpHandler] implementation for bootstrapping all critical services.
/// ✅ All dependencies are injectable for testing/mocking.

final class DefaultStartUpHandler extends IStartUpHandler {
  /// ────────────────────-----------------------------
  //
  final ILocalizationStack _localizationStack;
  final IFirebaseStack _firebaseStack;
  final ILocalStorageStack _localStorageStack;
  final IDebugTools _debugTools;
  final IOthersBootstrap _othersBootstrap;
  // final IDiConfig _diConfig;

  /// Creates a fully-configurable startup handler.
  /// All dependencies are optional and will default to production implementations.
  const DefaultStartUpHandler({
    ILocalizationStack? localizationStack,
    IFirebaseStack? firebaseStack,
    ILocalStorageStack? localStorageStack,
    IDebugTools? debugTools,
    IOthersBootstrap? othersBootstrap,
    IDiConfig? diConfig,
  }) : _localizationStack =
           localizationStack ?? const DefaultLocalizationStack(),
       _firebaseStack = firebaseStack ?? const DefaultFirebaseStack(),
       _localStorageStack =
           localStorageStack ?? const DefaultLocalStorageStack(),
       _debugTools = debugTools ?? const DefaultDebugTools(),
       _othersBootstrap = othersBootstrap ?? const DefaultOthersBootstrap();
  //  _diConfig = diConfig ?? const DefaultDiConfig();

  ///

  @override
  Future<void> preBootstrap() async {
    /// 🚀 Launch Loader, while app is initializing
    final themeMode = await resolveThemeMode();
    runApp(InitialLoader(themeMode: themeMode));
  }

  /// Main entrypoint: sequentially bootstraps all core app services before [runApp]
  @override
  Future<void> bootstrap() async {
    //
    _debugTools.configure();
    await _debugTools.validatePlatformSupport();

    initDIContainer();

    await _localizationStack.init();

    await _localStorageStack.init();

    await _firebaseStack.init();

    _othersBootstrap.initUrlStrategy();

    //
  }

  /// Creates a global DI container for access outside widget tree.
  /// ProviderScope inherits this via `parent`, ensuring shared DI and consistent overrides between imperative code and widgets tree.
  Future<ProviderContainer> initDIContainer() async {
    //
    globalContainer = ProviderContainer(
      overrides: diOverrides,
      // overrides: testOverrides, // for tests
      observers: [Logger()],
    );
    return globalContainer;
  }

  //
}
