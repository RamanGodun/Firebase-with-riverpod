part of 'error_plugins.dart';

/// 🗝️ [FailureKeys] — Localizable error keys for [Failure]
/// 🧩 Used with i18n and [AppLocalizer] to resolve messages

enum FailureKeys {
  //
  networkNoConnection, // 🌐 No internet / offline
  networkTimeout, // ⏳ Request timeout
  unauthorized, // 🔐 401 or invalid session

  firebaseGeneric, // 🔥 Generic Firebase error
  firebaseDocMissing, // 📄 Firestore doc invalid or missing
  firebaseInvalidCredential, // ❌ Wrong login/password
  firebaseUserNotFound, // 👤 Email not registered
  firebaseWrongPassword, // 🔑 Valid email, wrong password
  firebaseNoCurrentUser, // 🚫 FirebaseAuth.currentUser == null
  firebaseInvalidEmail, // 📬 Email format is invalid
  firebaseMissingEmail, // 📭 Email is empty or null
  firebaseTooManyRequests, // 🧨 Throttled / IP blocked

  formatError, // 📦 JSON parsing or data format
  unknown, // ❓ Unexpected or unclassified
  missingPlugin; // 🧩 Platform plugin not available

  ///

  /// 🌐 Maps each key to translation ID for localization
  String get translationKey => switch (this) {
    //
    networkNoConnection => 'failure.network.no_connection',
    networkTimeout => 'failure.network.timeout',
    unauthorized => 'failure.auth.unauthorized',

    firebaseGeneric => 'failure.firebase.generic',
    firebaseDocMissing => 'failure.firebase.doc_missing',
    firebaseInvalidCredential => 'failure.firebase.invalid_credential',
    firebaseUserNotFound => 'failure.firebase.user_not_found',
    firebaseWrongPassword => 'failure.firebase.wrong_password',
    firebaseNoCurrentUser => 'failure.firebase.no_current_user',
    firebaseInvalidEmail => 'failure.firebase.invalid_email',
    firebaseMissingEmail => 'failure.firebase.missing_email',
    firebaseTooManyRequests => 'failure.firebase.too_many_requests',

    formatError => 'failure.format.error',
    unknown => 'failure.unknown',
    missingPlugin => 'failure.plugin.missing',
  };
}
