part of '../core_of_module/exceptions_to_failures_mapper.dart';

/// 📦 [ExceptionToFailureX] — Extensible extension to map any exception to [Failure]
/// ✅ Cleanly separates mapping logic from core mapper
/// ✅ New handlers can be added without touching core
/// ✅ Matches pattern from legacy [ExceptionToFailureMapper.from]
//
extension ExceptionToFailureX on Object {
  /// 🛡️ Converts any error into domain-level [Failure].
  Failure mapToFailure() => switch (this) {
    // 🌐 No connection
    SocketException error => _handleSocket(error),

    // ⏳ Timeout
    TimeoutException error => _handleTimeout(error),

    // 🌍 Legacy HTTP error
    HttpException error => _handleHttp(error),

    // 🔌 Dio error handler
    DioException error => _handleDio(error),

    // 🧊 Firebase edge-case
    FirebaseAuthException error => _handleFirebaseAuth(error),

    // 🔥 Firebase codes
    FirebaseException error => _handleFirebase(error),

    // 📄 Firestore-specific parsing issue
    FormatException(:final message) when message.contains('document') == true =>
      FirestoreDocMissingFailure(),

    // ⚙️ Native platform
    PlatformException error => _handlePlatform(error),

    // 📦 Plugin missing
    MissingPluginException error => _handleMissingPlugin(error),

    // 🧾 Bad format
    FormatException error => _handleFormat(error),

    // 🧬 JSON failure
    JsonUnsupportedObjectError error => _handleJson(error),

    // 💾 Storage error
    FileSystemException error => _handleFileSystem(error),

    // 🧠 Invalid arguments
    ArgumentError error => _handleArgument(error),

    // ❓ Fallback for uncategorized
    _ => UnknownFailure(
      message: toString(),
      translationKey: FailureTranslationKeys.unknown,
    ),
  };

  //
}
