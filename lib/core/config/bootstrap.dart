import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_strategy/url_strategy.dart' show setPathUrlStrategy;
import '../../data/sources/remote/env_firebase_options.dart';
import '../config/env.dart';
import '../utils_and_services/firebase_util.dart';
import 'app_config.dart';
import 'package:device_info_plus/device_info_plus.dart';

/// 🧰 Bootstrap: Loads .env, initializes Firebase
Future<void> bootstrapApp() async {
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
}
