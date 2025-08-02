import '../failure_source.dart';
import '../../core_of_module/failure_entity.dart';

/// 🧭 [FailureX] — Unified extensions for `Failure`
/// ✅ Includes semantic type-checkers, diagnostics, logging helpers, casting, and safe metadata access.
/// ✅ Used in conditional logic, logging, Crashlytics, result handlers, and UI mapping.
//
extension FailureX on Failure {
  ///────────────────────────
  //
  /// 🔍 SEMANTIC TYPE CHECKERS
  /// ✅ Replaces `is SomeFailure` with readable intent
  /// ✅ Improves clarity in conditional logic (UI/logic branching)

  /// ❌ True if failure is due to lack of network or timeout
  bool get isNetwork => this is NetworkFailure || this is TimeoutFailure;

  /// 🔒 True if failure was caused by unauthorized access (401)
  bool get isUnauthorized => this is UnauthorizedFailure;

  /// 🔥 True if failure originated from Firebase layer
  bool get isFirebase => this is FirebaseFailure;

  /// 💾 True if failure is from local cache or preferences
  bool get isCache => this is CacheFailure;

  /// 🌐 True if failure is HTTP-level (non-auth)
  bool get isApi => this is ApiFailure;

  /// ❓ True if failure is uncategorized or fallback
  bool get isUnknown => this is UnknownFailure;

  /// ⚙️ True if failure was caused by a plugin/platform system issue
  bool get isPlatform => this is GenericFailure;

  /// 🧠 True if failure occurred in business/use-case logic
  bool get isUseCase => this is UseCaseFailure;

  /// ⏱ True if failure was due to timeout
  bool get isTimeout => this is TimeoutFailure;

  /// 📩 True if failure is specific to email verification timeout
  bool get isEmailVerification => this is EmailVerificationFailure;

  /// 🧊 True if failure comes from Firestore document structure
  bool get isFirestoreDocMissing => this is FirestoreDocMissingFailure;

  /// 🔍 True if failure is due to missing current FirebaseUser
  bool get isFirebaseUserMissing => this is FirebaseUserMissingFailure;

  //

  /// 🔌 Source & Type Diagnostics
  /// ✅ Used in logs, analytics, crash reports

  /// Returns plugin source identifier
  String get pluginSource => switch (this) {
    GenericFailure() => statusCode?.toString() ?? FailureSource.unknown.code,
    ApiFailure() => FailureSource.httpClient.code,
    FirebaseFailure() => FailureSource.firebase.code,
    UseCaseFailure() => FailureSource.useCase.code,
    UnauthorizedFailure() => 'AUTH',
    CacheFailure() => 'CACHE',
    NetworkFailure() => FailureSource.httpClient.code,
    TimeoutFailure() => FailureSource.httpClient.code,
    EmailVerificationFailure() => FailureSource.useCase.code,
    _ => FailureSource.unknown.code,
  };

  /// True if failure is related to network (e.g. no internet, timeout)
  bool get isNetworkFailure => pluginSource == FailureSource.httpClient.code;

  /// True if failure originated from Firebase
  bool get isFirebaseFailure => this is FirebaseFailure;

  /// True if failure indicates unauthenticated access (401, expired token)
  bool get isUnauthorizedFailure => this is UnauthorizedFailure;

  /// True if failure is related to cache/storage layer
  bool get isCacheFailure => this is CacheFailure;

  /// True if failure is a fallback for unknown/unhandled exceptions
  bool get isUnknownFailure => this is UnknownFailure;

  //

  /// 🔁 Runtime Casting & Metadata

  /// Safe type-cast of the current failure to a specific subtype
  T? as<T extends Failure>() => this is T ? this as T : null;

  /// Returns non-null error code (for logs, identifiers)
  String get safeCode => code ?? 'UNKNOWN_CODE';

  /// Returns stringified status (e.g. HTTP or plugin code)
  String get safeStatus => statusCode?.toString() ?? 'NO_STATUS';

  /// Developer-friendly label combining code and message
  String get label => '\$safeCode — \$message';

  //

}
