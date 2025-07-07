import 'package:flutter/material.dart';
import 'core/layers_shared/_infrastructure_layer/_bootstrap/debug_tools.dart';
import 'core/layers_shared/_infrastructure_layer/_bootstrap/firebase_init.dart';
import 'core/layers_shared/_infrastructure_layer/_bootstrap/local_storage_init.dart';
import 'core/layers_shared/_infrastructure_layer/_bootstrap/localization_init.dart';
import 'core/layers_shared/_infrastructure_layer/_bootstrap/others_bootstrap.dart';

/// 🧰 [StartUpHandler] — Abstract contract for app startup logic

sealed class StartUpHandler {
  ///----------------------
  const StartUpHandler();

  ///
  Future<void> bootstrap();
  //
}

////

////

/// 🧰 [DefaultStartUpHandler] — Production [StartUpHandler] implementation for bootstrapping all critical services.
/// ✅ All dependencies are injectable for testing/mocking.

final class DefaultStartUpHandler extends StartUpHandler {
  /// ────────────────────-----------------------------
  //
  final ILocalizationStack _localizationStack;
  final IFirebaseStack _firebaseStack;
  final ILocalStorageStack _localStorageStack;
  final IDebugTools _debugTools;
  final IOthersBootstrap _othersBootstrap;

  /// Creates a fully-configurable startup handler.
  /// All dependencies are optional and will default to production implementations.
  const DefaultStartUpHandler({
    ILocalizationStack? localizationStack,
    IFirebaseStack? firebaseStack,
    ILocalStorageStack? localStorageStack,
    IDebugTools? debugTools,
    IOthersBootstrap? othersBootstrap,
  }) : _localizationStack =
           localizationStack ?? const DefaultLocalizationStack(),
       _firebaseStack = firebaseStack ?? const DefaultFirebaseStack(),
       _localStorageStack =
           localStorageStack ?? const DefaultLocalStorageStack(),
       _debugTools = debugTools ?? const DefaultDebugTools(),
       _othersBootstrap = othersBootstrap ?? const DefaultOthersBootstrap();

  //

  /// Main entrypoint: sequentially bootstraps all core app services before [runApp]
  @override
  Future<void> bootstrap() async {
    //
    _debugTools.configure();
    await _debugTools.validatePlatformSupport();

    await _localizationStack.init();

    await _localStorageStack.init();

    await _firebaseStack.init();

    _othersBootstrap.initUrlStrategy();
    //
  }

  //
}
