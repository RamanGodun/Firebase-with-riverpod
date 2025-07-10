import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_core_initializations/debug_tools.dart';
import 'app_core_initializations/local_storage.dart';
import 'app_core_initializations/platform_validation.dart';
import 'di_container/di_config_sync.dart';
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
  final DIConfigSync _diConfiguration;

  /// Creates a fully-configurable startup handler.
  /// All dependencies are injectable and default to production implementations if not provided.
  AppStartUp({
    IPlatformValidator? platformValidator,
    IDebugTools? debugTools,
    ILocalStorageStack? localStorageStack,
    DIConfigSync? diConfiguration,
  }) : _platformValidator =
           platformValidator ?? const PlatformValidationStack(),
       _debugTools = debugTools ?? const DebugTools(),
       _localStorageStack = localStorageStack ?? const LocalStorageStack(),
       _diConfiguration = diConfiguration ?? DefaultDIConfiguration();

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
    // ... (other debug tools)
  }

  ////

  @override
  Future<void> initGlobalDIContainer() async {
    //
    // Global DI for use both outside widget tree and for ProviderScope.parent
    //  ensuring shared DI and consistent overrides between imperative code and widgets tree.
    final ProviderContainer getGlobalContainer = ProviderContainer(
      overrides: _diConfiguration.overrides,
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
