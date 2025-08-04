import '../../core_of_module/failure_entity.dart';

/// 🧭 [FailureX] — Unified extensions for [Failure]
/// ✅ Includes semantic type-checkers, diagnostics, casting, and safe metadata access
/// ✅ Used in conditional logic, logging, Crashlytics, result handlers, and UI mapping
//
extension FailureX on Failure {
  //────────────────────────
  // 🔍 SEMANTIC TYPE CHECKERS
  // ✅ Declarative failure-type checks for branching and logic

  bool get isNetworkFailure => type.code == 'NETWORK';
  bool get isUnauthorizedFailure => type.code == 'UNAUTHORIZED';
  bool get isApiFailure => type.code == 'API';
  bool get isUnknownFailure => type.code == 'UNKNOWN';
  bool get isUseCaseFailure => type.code == 'USE_CASE';
  bool get isTimeoutFailure => type.code == 'TIMEOUT';
  bool get isEmailVerificationFailure =>
      type.code == 'EMAIL_VERIFICATION' ||
      type.code == 'EMAIL_VERIFICATION_TIMEOUT';
  bool get isFirestoreDocMissingFailure => type.code == 'FIRESTORE_DOC_MISSING';
  bool get isFirebaseUserMissingFailure => type.code == 'FIREBASE_USER_MISSING';
  bool get isCacheFailure => type.code == 'CACHE';
  bool get isFirebaseFailure => type.code == 'FIREBASE';
  bool get isFormatErrorFailure => type.code == 'FORMAT_ERROR';
  bool get isMissingPluginFailure => type.code == 'MISSING_PLUGIN';
  bool get isJsonErrorFailure => type.code == 'JSON_ERROR';
  bool get isInvalidCredential => type.code == 'INVALID_CREDENTIAL';

  //────────────────────────
  // 🔁 Casting & Metadata access

  /// Safe type-cast of the current failure to a specific subtype
  T? as<T extends Failure>() => this is T ? this as T : null;

  /// Non-null error code (e.g., for display, logs)
  String get safeCode => statusCode?.toString() ?? type.code;

  /// Optional numeric status (e.g. HTTP, plugin, etc.)
  String get safeStatus => statusCode?.toString() ?? 'NO_STATUS';

  /// Developer-friendly diagnostic label
  String get label => '$safeCode — ${message ?? "No message"}';

  //
}
