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

  /// 🎯 Entry point — must be called before `runApp`
  static Future<void> initialize() async {
    // 📦 Ensures all necessary bindings are ready before app initialization
    WidgetsFlutterBinding.ensureInitialized();

    await _initLocalization();
    await _initLocalStorage();
    // ...
  }

  /// 🌍 Ensures EasyLocalization is initialized before `runApp`
  static Future<void> _initLocalization() async {
    await EasyLocalization.ensureInitialized();
    AppLocalizer.init(
      resolver: (key) => key.tr(),
    ); // ? when app with localization
    //
    // ! when app without localization, then instead previous method use next:
    // AppLocalizer.init(resolver: (key) => LocalesFallbackMapper.fallbackMap[key] ?? key)
  }

  static Future<void> _initLocalStorage() async {
    /// 💾🗂 Initialize local storages
    await GetStorage.init();
    // final sharedPrefs = await SharedPreferences.getInstance();
  }

  ///
}

Future<void> bootstrap() async {
  ///
  /// 🟡 Check is android version
  if (Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt < AppConfig.minSdkVersion) {
      throw UnsupportedError(
        'Android SDK ${androidInfo.version.sdkInt} is not supported. Minimum is ${AppConfig.minSdkVersion}',
      );
    }
  }

  ///📀 Loads .env
  final envFile = switch (EnvConfig.currentEnv) {
    Environment.dev => '.env.dev',
    Environment.staging => '.env.staging',
    Environment.prod => '.env',
  };
  await dotenv.load(fileName: envFile);
  debugPrint('✅ Loaded env file: $envFile');

  /// 🔥 Firebase init with duplicate guard
  if (!FirebaseUtils.isDefaultAppInitialized) {
    try {
      await Firebase.initializeApp(options: EnvFirebaseOptions.currentPlatform);
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

  // 🧭 Web-friendly URLs
  setPathUrlStrategy();

  //
}




/*

 */