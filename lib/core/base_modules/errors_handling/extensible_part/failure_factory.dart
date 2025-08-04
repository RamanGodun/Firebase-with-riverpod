import '../core_of_module/failure_entity.dart';
import '../core_of_module/failure_type.dart';

/// 🏭 [FailureFactory] — centralized factory for creating [Failure]s
/// ✅ Uses standardized [FailureType]
/// ✅ No longer includes hardcoded messages (handled via i18n keys in UI)
/// ✅ Supports optional [statusCode] where needed
//
abstract final class FailureFactory {
  FailureFactory._();
  //

  /// 🌐 No internet connection
  static Failure network({String? message}) =>
      Failure(type: const NetworkFailureType(), message: message);

  // ⏱ Timeout reached
  static const timeout = Failure(type: NetworkTimeoutFailureType());

  // 🔥 Firebase generic error

  static Failure accountExistsWithDifferentCredential({String? message}) =>
      Failure(
        type: const AccountExistsWithDifferentCredentialFirebaseFT(),
        message: message,
      );

  /// 🔐 Firebase currentUser == null
  static Failure firebaseUserMissing({String? message}) =>
      Failure(type: const UserMissingFirebaseFT(), message: message);

  /// 📄 Firebase user profile document not found in Firestore
  static Failure firebaseUserNotFound({String? message}) =>
      Failure(type: const UserNotFoundFirebaseFT(), message: message);

  // 📄 Firestore doc missing
  static const firestoreDocMissing = Failure(type: DocMissingFirebaseFT());

  ///

  ///

  // 🔓 Unauthorized access (401)
  static const unauthorized = Failure(
    type: UnauthorizedFailureType(),
    statusCode: 401,
  );

  // 💾 Cache-related error
  static const cache = Failure(type: CacheFailureType());

  // 🧠 UseCase / validation failure
  static const useCase = Failure(type: UseCaseFailureType());

  // 📧 Email verification timeout
  static const emailVerificationTimeout = Failure(
    type: EmailVerificationTimeoutFailureType(),
  );

  // 🧾 Malformed data
  static const format = Failure(type: FormatErrorFailureType());

  // 🔢 JSON encoding/decoding issue
  static Failure json(Object? cause) =>
      const Failure(type: JsonErrorFailureType());

  // 🧩 Plugin missing
  static const missingPlugin = Failure(type: MissingPluginFailureType());

  // 🌐 API error with status code
  static Failure api(int code) =>
      Failure(type: const ApiFailureType(), statusCode: code);

  // 🧊 SQLite failure
  static const sqlite = Failure(type: SqliteFailureType());

  // ⚙️ Platform channel exception
  static const platform = Failure(type: PlatformFailureType());

  // ❓ Unknown fallback
  static const unknown = Failure(type: UnknownFailureType());
}
