library;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// 🧩 [EnvFirebaseOptions] — platform-based FirebaseOptions generator
/// 📦 Firebase configuration based on current environment (.env + flutter_dotenv)
/// 🧼 Uses `flutter_dotenv` to securely read platform-specific values from `.env`
/// 🔧 Platforms supported:
///      - ✅ Android
///      - ✅ iOS
///      - ✅ Web
///      - ❌ macOS, Windows, Linux (throws [UnsupportedError])
//----------------------------------------------------------------//
final class EnvFirebaseOptions {
  /// 🧱 Returns [FirebaseOptions] for the current platform
  static FirebaseOptions get currentPlatform {
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => _android,
      TargetPlatform.iOS => _ios,
      TargetPlatform.macOS => throw UnsupportedError('❌ macOS not supported'),
      TargetPlatform.windows =>
        throw UnsupportedError('❌ Windows not supported'),
      TargetPlatform.linux => throw UnsupportedError('❌ Linux not supported'),
      _ when kIsWeb => _web,
      _ => throw UnsupportedError('❌ Unknown platform'),
    };
  }

  static String _env(String key) => dotenv.env[key]!;

  /// 🤖 Android config (read from .env)
  static FirebaseOptions get _android => FirebaseOptions(
    apiKey: _env('FIREBASE_API_KEY'),
    appId: dotenv.env['FIREBASE_APP_ID']!,
    projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
    messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
    storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '',
  );

  /// 🍏 iOS config (read from .env)
  static FirebaseOptions get _ios => FirebaseOptions(
    apiKey: _env('FIREBASE_API_KEY'),
    appId: dotenv.env['FIREBASE_APP_ID']!,
    projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
    messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
    iosBundleId: dotenv.env['FIREBASE_IOS_BUNDLE_ID'],
    storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '',
  );

  /// 🌍 Web config (read from .env)
  static FirebaseOptions get _web => FirebaseOptions(
    apiKey: _env('FIREBASE_API_KEY'),
    appId: dotenv.env['FIREBASE_APP_ID']!,
    projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
    messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
    authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN'],
    storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '',
  );
}
