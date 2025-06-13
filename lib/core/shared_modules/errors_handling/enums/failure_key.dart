part of 'error_plugins.dart';

/// 🗝️ [FailureKeys] — Localizable error keys for [Failure]
/// 🧩 Used with i18n and [AppLocalizer] to resolve messages
enum FailureKeys {
  //
  networkNoConnection, // No internet / offline
  networkTimeout, // Request timeout
  unauthorized, // 401 or invalid session
  firebaseGeneric, // Generic Firebase error
  firebaseDocMissing, // Firestore doc invalid/missing
  formatError, // Parsing/format issue
  unknown, // Fallback key for unknowns
  firebaseInvalidCredential, // Wrong login/password
  firebaseUserNotFound, // Email not registered
  firebaseWrongPassword, // Valid email, wrong pass
  missingPlugin; // Platform plugin not available

  // ...
  // other failure

  /// 🌐 Maps each key to translation ID for localization
  String get translationKey => switch (this) {
    //
    networkNoConnection => 'failure.network.no_connection',
    networkTimeout => 'failure.network.timeout',
    unauthorized => 'failure.auth.unauthorized',
    firebaseGeneric => 'failure.firebase.generic',
    firebaseDocMissing => 'failure.firebase.doc_missing',
    formatError => 'failure.format.error',
    unknown => 'failure.unknown',
    firebaseInvalidCredential => 'failure.firebase.invalid_credential',
    firebaseUserNotFound => 'failure.firebase.user_not_found',
    firebaseWrongPassword => 'failure.firebase.wrong_password',
    missingPlugin => 'failure.plugin.missing',
  };

  //
}
