part of '../core_of_module/failure_entity.dart';

/// 🏭 [FailureFactory] — centralized factory for creating [Failure]s
/// ✅ Uses standardized [FailureType]
/// ✅ No longer includes hardcoded messages (handled via i18n keys in UI)
/// ✅ Supports optional [statusCode] where needed
//
abstract final class FailureFactory {
  // 🌐 No internet connection
  static const network = Failure._(type: NetworkFailureType());

  // ⏱ Timeout reached
  static const timeout = Failure._(type: NetworkTimeoutFailureType());

  // 🔥 Firebase generic error
  static const firebase = Failure._(type: FirebaseFailureType());

  static const userDisabled = Failure._(type: UserDisabledFirebaseFT());
  static const emailAlreadyInUse = Failure._(
    type: EmailAlreadyInUseFirebaseFT(),
  );
  static const operationNotAllowed = Failure._(
    type: OperationNotAllowedFirebaseFT(),
  );
  static const weakPassword = Failure._(type: WeakPasswordFirebaseFT());
  static const userNotFound = Failure._(type: UserNotFoundFirebaseFT());

  static const requiresRecentLogin = Failure._(
    type: RequiresRecentLoginFirebaseFT(),
  );

  static const invalidCredential = Failure._(
    type: InvalidCredentialFirebaseFT(),
  );

  // 🔥 Firebase generic with message
  static Failure firebaseWithMessage(String message) =>
      Failure._(type: const FirebaseFailureType(), message: message);

  /// 🔐 Firebase currentUser == null
  static Failure firebaseUserMissing({String? message}) =>
      Failure._(type: const FirebaseUserMissingFailureType(), message: message);

  /// 📄 Firebase user profile document not found in Firestore
  static Failure firebaseUserNotFound({String? message}) => Failure._(
    type: const FirebaseUserNotFoundFailureType(),
    message: message,
  );

  // 📄 Firestore doc missing
  static const firestoreDocMissing = Failure._(
    type: FirestoreDocMissingFailureType(),
  );

  // 🔓 Unauthorized access (401)
  static const unauthorized = Failure._(
    type: UnauthorizedFailureType(),
    statusCode: 401,
  );

  // 💾 Cache-related error
  static const cache = Failure._(type: CacheFailureType());

  // 🧠 UseCase / validation failure
  static const useCase = Failure._(type: UseCaseFailureType());

  // 📧 Email verification timeout
  static const emailVerificationTimeout = Failure._(
    type: EmailVerificationTimeoutFailureType(),
  );

  // 🧾 Malformed data
  static const format = Failure._(type: FormatErrorFailureType());

  // 🔢 JSON encoding/decoding issue
  static Failure json(Object? cause) =>
      const Failure._(type: JsonErrorFailureType());

  // 🧩 Plugin missing
  static const missingPlugin = Failure._(type: MissingPluginFailureType());

  // 🌐 API error with status code
  static Failure api(int code) =>
      Failure._(type: const ApiFailureType(), statusCode: code);

  // 🧊 SQLite failure
  static const sqlite = Failure._(type: SqliteFailureType());

  // ⚙️ Platform channel exception
  static const platform = Failure._(type: PlatformFailureType());

  // ❓ Unknown fallback
  static const unknown = Failure._(type: UnknownFailureType());
}
