import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/layers_shared/_infrastructure_layer/bootstrap/firebase_init.dart';
import 'core/layers_shared/_infrastructure_layer/bootstrap/localization_init.dart';
import 'core/layers_shared/_infrastructure_layer/bootstrap/others_bootstrap.dart';

/// 🧰 [StartUpHandler] — Abstract contract for app startup logic

sealed class IAppBootstrap {
  ///----------------------------------
  const IAppBootstrap();
  //
  /// 🚀 Main initialization: all services and dependencies
  Future<void> run();
  //
}

////

////

/// 🧰 [DefaultStartUpHandler] — Production [StartUpHandler] implementation for bootstrapping all critical services.
/// ✅ All dependencies are injectable for testing/mocking.

final class DefaultStartUpHandler extends IAppBootstrap {
  /// ────────────────────-----------------------------
  //
  final ILocalizationStack _localizationStack;
  final IFirebaseStack _firebaseStack;
  // final ILocalStorageStack _localStorageStack;
  final IOthersBootstrap _othersBootstrap;

  /// Creates a fully-configurable startup handler.
  /// All dependencies are optional and will default to production implementations.
  const DefaultStartUpHandler({
    ILocalizationStack? localizationStack,
    IFirebaseStack? firebaseStack,
    // ILocalStorageStack? localStorageStack,
    IOthersBootstrap? othersBootstrap,
  }) : _localizationStack =
           localizationStack ?? const DefaultLocalizationStack(),
       _firebaseStack = firebaseStack ?? const DefaultFirebaseStack(),
       //  _localStorageStack =
       //  localStorageStack ?? const DefaultLocalStorageStack(),
       _othersBootstrap = othersBootstrap ?? const DefaultOthersBootstrap();

  ////

  /// Main entrypoint: sequentially bootstraps all core app services before [runApp]
  @override
  Future<void> run() async {
    //
    await _localizationStack.init();
    //
    await _firebaseStack.init();
    //
    _othersBootstrap.initUrlStrategy();
    //
  }

  //
}

final bootstrapProvider = FutureProvider<void>((ref) async {
  ///
  /// 🚀 Runs all imperative startup logic (localization, Firebase, storage, etc).
  /// StartupHandler can access DI from globalContainer outside context.
  final startUpHandler = const DefaultStartUpHandler(
    // ? Here can be plugged in custom dependencies, e.g.:
    // firebaseStack: MockFirebaseStack(),
  );
  await startUpHandler.run();
});
