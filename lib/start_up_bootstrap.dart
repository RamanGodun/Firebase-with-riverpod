import 'package:flutter/material.dart';
import 'core/layers_shared/_infrastructure_layer/_bootstrap/debug_tools.dart';
import 'core/layers_shared/_infrastructure_layer/_bootstrap/firebase_init.dart';
import 'core/layers_shared/_infrastructure_layer/_bootstrap/local_storage_init.dart';
import 'core/layers_shared/_infrastructure_layer/_bootstrap/localization_init.dart';
import 'core/layers_shared/_infrastructure_layer/_bootstrap/others_boostrap.dart';

/// 🧰 [StartUpHandler] — Abstract contract for app startup logic
/// ✅ Must be called before [runApp] to initialize critical services

sealed class StartUpHandler {
  ///----------------------
  const StartUpHandler();

  ///
  Future<void> bootstrap();
  //
}

////

////

///🧰 Handles all startup initialization tasks
// ✅ Sequentially initializes all critical services

final class DefaultStartUpHandler extends StartUpHandler {
  /// ────────────────────-----------------------------
  //
  final ILocalizationStack _localizationStack;
  final IFirebaseStack _firebaseStack;
  final ILocalStorageStack _localStorageStack;
  final IDebugTools _debugTools;
  final IOthersBootstrap _othersBootstrap;

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

  /// 🎯 Entry point — must be called before [runApp]
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
