library;

/// ⚙️ [AppConfig] — Global static configuration for the application.
/// Centralized constants for:
///       - App identity
///       - Versioning
///       - Platform requirements
///       - Global timeouts, flags, and feature toggles

final class AppConfig {
  AppConfig._();

  /// ═══════════════════════════════════════════════════════════════
  // 🧾 App Identity & Versioning
  // ═══════════════════════════════════════════════════════════════

  /// 🧾 Application display name
  static const String appName = 'Firebase with Riverpod';

  /// 🧾 Application version (sync with pubspec.yaml)
  static const String version = '0.1.0';

  /// 🏷️ Application ID / bundle ID
  static const String androidAppId = 'com.example.firebaseWithRiverpod';
  static const String iosBundleId = 'com.example.firebaseWithRiverpod';

  // ═══════════════════════════════════════════════════════════════
  // 📱 Platform Requirements
  // ═══════════════════════════════════════════════════════════════

  /// 📱 Minimum Android SDK version supported
  static const int minSdkVersion = 23;

  /// 📲 Minimum iOS version supported (informational only)
  static const String minIosVersion = '13.0';

  // ═══════════════════════════════════════════════════════════════
  // ⏱️ Timeouts / Limits
  // ═══════════════════════════════════════════════════════════════

  /// ⏱️ Global timeout for network requests
  static const Duration requestTimeout = Duration(seconds: 10);

  /// ⏳ Timeout for Firebase operations
  static const Duration firebaseTimeout = Duration(seconds: 20);

  /// 💤 Debounce duration for text field validation
  static const Duration debounceDuration = Duration(milliseconds: 350);

  // ═══════════════════════════════════════════════════════════════
  // 🚀 Build Mode Flags
  // ═══════════════════════════════════════════════════════════════

  /// 🧪 Flag for release mode
  static const bool isReleaseMode = bool.fromEnvironment('dart.vm.product');

  /// 👀 Flag for debug mode
  static bool get isDebugMode => !isReleaseMode;

  /// 🧪 Flag for test environment (e.g. Flutter test)
  static const bool isTestMode = bool.fromEnvironment('FLUTTER_TEST');

  /// 🤖 CI/CD flag (GitHub Actions, Bitbucket Pipelines, etc.)
  static const bool isCI = bool.fromEnvironment('CI');

  // ═══════════════════════════════════════════════════════════════
  // 🧪 Feature Toggles
  // ═══════════════════════════════════════════════════════════════

  /// 🚧 Toggle feature flags (can be overridden in .env or injected)
  static const bool enableExperimentalUI = false;

  /// 🔍 Enable detailed error logging
  static bool get showVerboseErrors => isDebugMode || isCI;

  // ═══════════════════════════════════════════════════════════════
  // 📂 Files / Assets
  // ═══════════════════════════════════════════════════════════════

  /// 🔐 Path to .env file fallback (for unit tests or CLI runs)
  static const String defaultEnvFile = '.env';
}
