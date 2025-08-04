/// 🧾 [FailureCodes] — centralized string constants for all known failure codes
/// ✅ Used to avoid magic strings across diagnostics, icons, factories, conditions
//
sealed class FailureCodes {
  ///

  /// ⚙️ Platform plugin errors
  static const platform = 'PLATFORM';

  /// 🌐 Network
  static const network = 'NETWORK';
  static const jsonError = 'JSON_ERROR';

  /// 🔥 Firebase Firestore
  static const firebase = 'FIREBASE';
  static const firebaseUserMissing = 'FIREBASE_USER_MISSING';
  static const firestoreDocMissing = 'FIRESTORE_DOC_MISSING';

  ///  Email verification failures
  static const emailVerificationTimeout = 'EMAIL_VERIFICATION_TIMEOUT';
  static const emailVerification = 'EMAIL_VERIFICATION';

  /// 🧊 SQLite / local DBs (not used yet)
  static const sqlite = 'SQLITE';

  static const useCase = 'USE_CASE';

  static const cache = 'CACHE';

  static const formatError = 'FORMAT_ERROR';

  static const missingPlugin = 'MISSING_PLUGIN';
  static const api = 'API';

  static const noStatus = 'NO_STATUS';

  static const timeout = 'TIMEOUT';

  static const unknown = 'UNKNOWN';
  static const unauthorized = 'UNAUTHORIZED';
  static const unknownCode = 'UNKNOWN_CODE';

  //
}

////

////
