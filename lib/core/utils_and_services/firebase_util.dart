import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// 🔍 Utility to check if [DEFAULT] FirebaseApp is already initialized
@immutable
final class FirebaseUtils {
  const FirebaseUtils._();

  /// ✅ Returns true if Firebase [DEFAULT] app is already initialized
  static bool get isDefaultAppInitialized {
    return Firebase.apps.any((app) => app.name == defaultFirebaseAppName);
  }

  /// 🧾 Prints all initialized Firebase apps
  static void logAllApps() {
    for (final app in Firebase.apps) {
      debugPrint('🧩 Firebase App: ${app.name} (${app.options.projectId})');
    }
  }
}
