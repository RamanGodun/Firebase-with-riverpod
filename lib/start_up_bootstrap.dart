import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart' show DeviceInfoPlugin;
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show debugRepaintRainbowEnabled;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_strategy/url_strategy.dart' show setPathUrlStrategy;
import 'core/app_configs/firebase/env.dart';
import 'core/modules_shared/localization/app_localizer.dart';
import 'core/app_configs/constants/platform_requirements.dart';
import 'core/app_configs/firebase/env_firebase_options.dart';
import 'core/app_configs/firebase/firebase_utils.dart';

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

////

///🧰 Handles all startup initialization tasks
// ✅ Sequentially initializes all critical services

final class DefaultStartUpHandler extends StartUpHandler {
  /// ────────────────────-----------------------------
  const DefaultStartUpHandler();
  //

  /// 🎯 Entry point — must be called before [runApp]
  @override
  Future<void> bootstrap() async {
    ///
    await _validatePlatformSupport();
    await _initLocalization();
    await _initLocalStorage();
    await _initEnvFile();
    await _initializeFirebase();
    _initUrlStrategy();
    _configureDebugTools();
    //
  }

  ////
  ////

  ///📱 Check minimum platform support (e.g., Android SDK)

  static Future<void> _validatePlatformSupport() async {
    ///
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

  ////

  ///🌍 Initializes localization engine (EasyLocalization)
  // ✅ Sets up `AppLocalizer` resolver

  static Future<void> _initLocalization() async {
    ///
    await EasyLocalization.ensureInitialized();
    AppLocalizer.init(resolver: (key) => key.tr());
    // AppLocalizer.initWithFallback(); // ← use if app has no translations
  }

  ////

  ///📀 Loads environment configuration (.env file)

  static Future<void> _initEnvFile() async {
    ///
    await dotenv.load(fileName: EnvConfig.currentEnv.fileName);
    debugPrint('✅ Loaded env file: $EnvConfig.currentEnv.fileName');
    //
  }

  ////

  /// 🔥 Initializes Firebase if not already initialized

  static Future<void> _initializeFirebase() async {
    ///
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
    //
  }

  ////

  ///💾 Initializes local storage services
  // ✅ Initializes GetStorage (local key-value DB)

  static Future<void> _initLocalStorage() async {
    ///
    await GetStorage.init();
    //
  }

  ////

  /// 🌐 Sets URL strategy for Flutter web
  // ✅ Removes `#` from web URLs for cleaner routing

  static void _initUrlStrategy() {
    ///
    setPathUrlStrategy();
    //
  }

  /// 🧪 Configures Flutter-specific debug tools
  /// ✅ Controls visual debugging options (e.g., repaint highlighting)

  static void _configureDebugTools() {
    ///
    debugRepaintRainbowEnabled = false;
    //
  }

  //
}
