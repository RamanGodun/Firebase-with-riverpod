import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart' show DeviceInfoPlugin;
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_strategy/url_strategy.dart' show setPathUrlStrategy;
import '../../../__for_each_project/firebase/env.dart';
import '../../shared_modules/localization/code_base_for_both_options/_app_localizer.dart';
import '../firebase/env_firebase_options.dart';
import '../firebase/firebase_utils.dart';
import '../app_config.dart';

/// 🧰 [AppBootstrap]: Loads .env, initializes Firebase,  local storage, etc
/// ---------------------------------------------------------------------
final class AppBootstrap {
  AppBootstrap._();

  /// 🎯 Entry point — must be called before [runApp]
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await _validatePlatformSupport();
    await _loadEnvFile();
    await _initLocalStorage();
    await _initializeFirebase();
    await _initLocalization();
    _initUrlStrategy();
  }

  ///

  /// ✅ Checks Android SDK version compatibility
  static Future<void> _validatePlatformSupport() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt < AppConfig.minSdkVersion) {
        throw UnsupportedError(
          'Android SDK ${androidInfo.version.sdkInt} is not supported. Minimum is ${AppConfig.minSdkVersion}',
        );
      }
    }
  }

  /// 📀 Loads .env configuration based on environment
  static Future<void> _loadEnvFile() async {
    final envFile = switch (EnvConfig.currentEnv) {
      Environment.dev => '.env.dev',
      Environment.staging => '.env.staging',
      Environment.prod => '.env',
    };
    await dotenv.load(fileName: envFile);
    debugPrint('✅ Loaded env file: $envFile');
  }

  /// 🔥 Initializes Firebase with duplicate check
  static Future<void> _initializeFirebase() async {
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

  /// 🌍 Ensures EasyLocalization is initialized before `runApp`
  static Future<void> _initLocalization() async {
    await EasyLocalization.ensureInitialized();
    // ? when app with localization, use this:
    AppLocalizer.init(resolver: (key) => key.tr());
    // ! when app without localization, then instead previous method use next:
    // AppLocalizer.initWithFallback();
  }

  static Future<void> _initLocalStorage() async {
    /// 💾🗂 Initialize local storages
    await GetStorage.init();
    // final sharedPrefs = await SharedPreferences.getInstance();
  }

  /// 🧭 Enables clean URLs for Flutter web
  static void _initUrlStrategy() {
    setPathUrlStrategy();
  }

  //
}
