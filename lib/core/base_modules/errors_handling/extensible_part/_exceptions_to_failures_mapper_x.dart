part of '../core_of_module/_run_errors_handling.dart';

/// 📦 [ExceptionToFailureX] — Extension to map any [Object] (Exception/Error) to a domain-level [Failure]
/// ✅ Handles known exceptions and maps them declaratively via [FailureFactory]
/// ✅ Clean, centralized, consistent fallback logic
//
extension ExceptionToFailureX on Object {
  Failure mapToFailure([StackTrace? stackTrace]) => switch (this) {
    // 🌐 No connection
    SocketException _ => FailureFactory.network,

    // ⏳ Timeout
    TimeoutException _ => FailureFactory.timeout,

    // 🔌 Dio error handler
    DioException error => switch (error.type) {
      //
      // ⏱️ Timeout-related Dio errors
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout => FailureFactory.timeout,

      //
      // 📡 HTTP response errors
      DioExceptionType.badResponse => switch (error.response?.statusCode) {
        final code? when code == 401 => FailureFactory.unauthorized,
        final code? when code >= 400 && code < 600 => FailureFactory.api(code),
        _ => FailureFactory.api(error.response?.statusCode ?? 0),
      },

      //
      // ❗ All other Dio cases
      _ => FailureFactory.network,
    },

    // 🔥 Firebase-specific auth issues
    FirebaseAuthException error => switch (error.code) {
      // 🧊 Edge-case: missing currentUser
      'internal-error' => FailureFactory.firebaseUserMissing(),
      _ => _mapFirebaseCode(error),
    },

    // 🔥 Firebase error code handling
    FirebaseException error => _mapFirebaseCode(error),

    // 📄 Firestore-specific malformed data
    FormatException(:final message) when message.contains('document') =>
      FailureFactory.firestoreDocMissing,

    // ⚙️ Platform channel errors
    PlatformException _ => FailureFactory.platform,

    // 🧩 Plugin missing
    MissingPluginException _ => FailureFactory.missingPlugin,

    // 🧾 Format parsing error
    FormatException _ => FailureFactory.format,

    // 🔢 JSON encoding/decoding error
    JsonUnsupportedObjectError error => FailureFactory.json(error.cause),

    // 💾 Local storage failure
    FileSystemException _ => FailureFactory.cache,

    // ❓ Unknown fallback
    _ => FailureFactory.unknown,
  };
}

/// 🔥 [_mapFirebaseCode] — maps [FirebaseException] to specific [Failure]s
/// ✅ Covers all known Firebase codes
//
Failure _mapFirebaseCode(FirebaseException error) => switch (error.code) {
  'network-request-failed' => FailureFactory.network,
  'email-already-in-use' => FailureFactory.emailAlreadyInUse,
  'invalid-credential' => FailureFactory.invalidCredential,
  'operation-not-allowed' => FailureFactory.firebase,
  'requires-recent-login' => FailureFactory.requiresRecentLogin,
  'too-many-requests' => FailureFactory.firebase,
  'user-disabled' => FailureFactory.firebase,
  'user-not-found' => FailureFactory.userNotFound,
  'weak-password' => FailureFactory.firebase,

  _ => FailureFactory.firebase,
};
