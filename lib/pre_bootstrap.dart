import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/foundation/logging/for_riverpod/riverpod_observer.dart';
import 'core/layers_shared/_infrastructure_layer/bootstrap/debug_tools.dart';
import 'core/layers_shared/_infrastructure_layer/bootstrap/local_storage_init.dart';
import 'core/layers_shared/_infrastructure_layer/di_container/di_container.dart';

sealed class IAppPreBootstrap {
  /// 🚀 Pre-initialization: Flutter bindings + splash loader + DI container
  Future<void> run();
  Future<ProviderContainer> initDIContainer();
}

final class AppPreBootstrap extends IAppPreBootstrap {
  final IDebugTools _debugTools;
  final ILocalStorageStack _localStorageStack;
  // final IDiConfig _diConfig;

  AppPreBootstrap({
    ILocalStorageStack? localStorageStack,
    IDebugTools? debugTools,
    // IDiConfig? diConfig,
  }) : _debugTools = debugTools ?? const DefaultDebugTools(),
       _localStorageStack =
           localStorageStack ?? const DefaultLocalStorageStack()
  //  _diConfig = diConfig ?? const DefaultDiConfig(),
  ;

  @override
  Future<void> run() async {
    // Initialize Flutter bindings
    WidgetsFlutterBinding.ensureInitialized();
    //
    _debugTools.configure();
    await _debugTools.validatePlatformSupport();
    //
    await _localStorageStack.init();
  }

  /// Creates a global DI container for access outside widget tree.
  /// ProviderScope inherits this via `parent`, ensuring shared DI and consistent overrides between imperative code and widgets tree.
  @override
  Future<ProviderContainer> initDIContainer() async {
    //
    final getGlobalContainer = ProviderContainer(
      overrides: diOverrides,
      // overrides: testOverrides, // for tests
      observers: [Logger()],
    );
    return getGlobalContainer;
  }

  //
}
