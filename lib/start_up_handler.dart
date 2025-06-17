import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart' show DeviceInfoPlugin;
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show debugRepaintRainbowEnabled;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_strategy/url_strategy.dart' show setPathUrlStrategy;
import 'core/app_configs/firebase/env.dart';
import 'core/modules_shared/di_container/di_container.dart';
import 'core/modules_shared/localization/app_localizer.dart';
import 'core/app_configs/constants/platform_requirements.dart';
import 'core/app_configs/firebase/env_firebase_options.dart';
import 'core/app_configs/firebase/firebase_utils.dart';

///🧰 Handles all startup initialization tasks
// ✅ Sequentially initializes all critical services

final class StartUpHandler {
  /// ────────────────────
  StartUpHandler._();
  //

  /// 🎯 Entry point — must be called before [runApp]
  static Future<void> bootstrap() async {
    /// ────────────────────────────────
    //
    _initializeCoreBindings();
    await _validatePlatformSupport();
    await _initLocalization();
    await _initLocalStorage();
    await _initEnvFile();
    await _initializeFirebase();
    _initUrlStrategy();
  }

  ////

  ///🛠️ Initializes fundamental Flutter bindings and core services
  // ✅ Sets up global Riverpod DI container with overrides
  static void _initializeCoreBindings() {
    /// ────────────────────────────────
    //
    WidgetsFlutterBinding.ensureInitialized();
    debugRepaintRainbowEnabled = false;
    globalContainer = ProviderContainer(overrides: diContainer);
  }

  ///🌍 Initializes localization engine (EasyLocalization)
  // ✅ Sets up `AppLocalizer` resolver
  static Future<void> _initLocalization() async {
    /// ────────────────────────────────────────
    //
    await EasyLocalization.ensureInitialized();
    AppLocalizer.init(resolver: (key) => key.tr());
    // AppLocalizer.initWithFallback(); // ← use if app has no translations
  }

  ///📱 Check minimum platform support (e.g., Android SDK)
  static Future<void> _validatePlatformSupport() async {
    /// ───────────────────────────────────────────────
    //
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt < PlatformConstants.minSdkVersion) {
        throw UnsupportedError(
          'Android SDK ${androidInfo.version.sdkInt} is not supported. '
          'Minimum is ${PlatformConstants.minSdkVersion}',
        );
      }
    }
  }

  ///📀 Loads environment configuration (.env file)
  static Future<void> _initEnvFile() async {
    /// ───────────────────────────────────
    //
    final envFile = switch (EnvConfig.currentEnv) {
      Environment.dev => '.env.dev',
      Environment.staging => '.env.staging',
      Environment.prod => '.env',
    };
    await dotenv.load(fileName: envFile);
    debugPrint('✅ Loaded env file: $envFile');
  }

  /// 🔥 Initializes Firebase if not already initialized
  static Future<void> _initializeFirebase() async {
    /// ──────────────────────────────────────────
    //
    if (!FirebaseUtils.isDefaultAppInitialized) {
      try {
        await Firebase.initializeApp(
          options: EnvFirebaseOptions.currentPlatform,
        );
        debugPrint('🔥 Firebase initialized!');
      } on FirebaseException catch (e) {
        if (e.code == 'duplicate-app') {
          debugPrint('⚠️ Firebase already initialized, skipping...');
        } else {
          rethrow;
        }
      }
    } else {
      debugPrint('⚠️ Firebase already initialized (checked manually)');
    }
    FirebaseUtils.logAllApps();
  }

  ///💾 Initializes local storage services
  // ✅ Initializes GetStorage (local key-value DB)
  static Future<void> _initLocalStorage() async {
    /// ───────────────────────────────────────-
    //
    await GetStorage.init();
    // SharedPreferences (if used) can be initialized here
    // final sharedPrefs = await SharedPreferences.getInstance();
  }

  /// 🌐 Sets URL strategy for Flutter web
  // ✅ Removes `#` from web URLs for cleaner routing
  static void _initUrlStrategy() {
    /// ────────────────────────
    //
    setPathUrlStrategy();
  }

  //
}
