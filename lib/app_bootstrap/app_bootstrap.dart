import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show debugRepaintRainbowEnabled;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_strategy/url_strategy.dart' show setPathUrlStrategy;
import '../core/foundation/localization/app_localizer.dart';
import 'remote_db_init.dart';
import 'local_storage_init.dart';
import 'platform_validation.dart';
import 'di_container/di_config_sync.dart';
import 'di_container/di_container.dart';

/// 🏁 [IAppBootstrap] —  Abstract contract for app startup logic

sealed class IAppBootstrap {
  ///------------------
  //
  /// 🚀 Main initialization: all services and dependencies
  Future<void> initAllServices();
  //
  /// Initializes Flutter bindings and debug tools
  Future<void> startUp();
  //
  /// Creates a global DI container accessible both outside and inside the widget tree.
  Future<void> initGlobalDIContainer();
  //
  /// Initialize local storage
  Future<void> initLocalStorage();
  //
  /// Initialize remote Database
  Future<void> initRemoteDataBase();

  /// ? Why split initialization into several methods?
  ///       Startup can be multi-phased:
  ///         - **Minimal bootstrap** — For a custom splash/loader (e.g., show initial loader while others setup runs).
  ///         -  **Full bootstrap** — For the complete initialization pipeline (all services/deps)
  //
  ///   This allows to display a loader/UI ASAP, while heavy initializations (services, Firebase, etc.) happen after.
  //
}

////

////

/// 🧰 [AppBootstrap] — Production [IAppBootstrap] implementation for bootstrapping all critical services.
/// ✅ All dependencies are injectable for testing/mocking, steps are separated for flexibility

final class AppBootstrap extends IAppBootstrap {
  ///-------------------------------------
  //
  final ILocalStorage _localStorage;
  final DIConfig _diConfiguration;
  final IRemoteDataBase _remoteDataBase;

  /// Creates a fully-configurable startup handler.
  /// All dependencies are injectable and default to production implementations if not provided.
  AppBootstrap({
    ILocalStorage? localStorageStack,
    DIConfig? diConfiguration,
    IRemoteDataBase? firebaseStack,
  }) : _localStorage = localStorageStack ?? const LocalStorage(),
       _diConfiguration = diConfiguration ?? DefaultDIConfiguration(),
       _remoteDataBase = firebaseStack ?? const FirebaseRemoteDataBase();

  ////
  ////

  /// Sequentially bootstraps all core app services
  @override
  Future<void> initAllServices() async {
    //
    await startUp();
    //
    await initGlobalDIContainer();
    //
    /// Ensures EasyLocalization is initialized before runApp.
    await initEasyLocalization();
    //
    /// Initializes local storage (currently, GetStorage).
    await initLocalStorage();
    //
    /// Initializes remote database (currently, Firebase).
    await initRemoteDataBase();
    setPathUrlStrategy();
    //
  }

  /// Minimal setup required for the initial app loader (or skeleton/splash screen).
  @override
  Future<void> startUp() async {
    //
    /// Ensures Flutter bindings.
    WidgetsFlutterBinding.ensureInitialized();
    //
    /// Validates platform (min. OS versions, emulator restrictions, etc).
    await PlatformValidationUtil.run();
    //
    /// Controls visual debugging options (e.g., repaint highlighting).
    debugRepaintRainbowEnabled = false;
  }

  ////

  /// Set uo global DI container for using outside widget tree and for ProviderScope.parent,
  /// that ensures consistent of shared DI both in/out context
  /// Should be initialized **once** before runApp.
  @override
  Future<void> initGlobalDIContainer() async {
    //
    final ProviderContainer getGlobalContainer = ProviderContainer(
      overrides: _diConfiguration.overrides,
      observers: _diConfiguration.observers,
    );
    //
    GlobalDIContainer.initialize(getGlobalContainer);
  }

  ////

  @override
  Future<void> initLocalStorage() async {
    /// Initializes local storage (currently, GetStorage).
    await _localStorage.init();
  }

  ////

  @override
  Future<void> initRemoteDataBase() async {
    /// Initializes remote database (currently, Firebase).
    await _remoteDataBase.init();
  }

  ////

  Future<void> initEasyLocalization() async {
    //
    debugPrint('🌍 Initializing EasyLocalization...');
    await EasyLocalization.ensureInitialized();
    //
    /// 🌍 Sets up the global localization resolver for the app.
    AppLocalizer.init(resolver: (key) => key.tr());
    // ? when app without localization, then instead previous method use next:
    // AppLocalizer.initWithFallback();
    debugPrint('🌍 EasyLocalization initialized!');
    //
  }

  //
}
