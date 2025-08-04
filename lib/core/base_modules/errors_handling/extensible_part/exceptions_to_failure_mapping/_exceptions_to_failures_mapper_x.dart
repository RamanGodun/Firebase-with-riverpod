part of '../../core_of_module/_run_errors_handling.dart';

/// 📦 [ExceptionToFailureX] — Extension to map any [Object] (Exception/Error) to a domain-level [Failure]
/// ✅ Handles known exceptions and maps them declaratively via [FailureFactory]
/// ✅ Clean, centralized, consistent fallback logic
//
extension ExceptionToFailureX on Object {
  Failure mapToFailure([StackTrace? stackTrace]) => switch (this) {
    // 🌐 No connection
    SocketException error => FailureFactory.network(message: error.message),

    // ⏳ Timeout
    TimeoutException _ => FailureFactory.timeout,

    // 🔌 Dio error handler
    DioException error => _mapDioError(error),

    // 🔥 Firebase error code handling
    FirebaseException error =>
      _firebaseFailureMap[error.code]?.call(error.message) ??
          Failure(type: const GenericFirebaseFT(), message: error.message),

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
