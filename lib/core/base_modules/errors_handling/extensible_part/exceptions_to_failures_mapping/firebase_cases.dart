part of '../../core_of_module/exceptions_to_failures_mapper.dart';

/// 🔥 [_handleFirebase] — maps [FirebaseException] to structured [Failure]s.
/// ✅ Handles all major Firebase error codes with localization support.
//
Failure _handleFirebase(FirebaseException error) => switch (error.code) {
  //
  'network-request-failed' => NetworkFailure(
    message: 'No Internet connection. Please check your network settings.',
    translationKey: FailureTranslationKeys.networkNoConnection,
  ),

  'email-already-in-use' => FirebaseFailure(
    message: error.message ?? 'Email already in use.',
    translationKey: FailureTranslationKeys.firebaseEmailInUse,
  ),

  'invalid-credential' => FirebaseFailure(
    message: error.message ?? 'Invalid credentials.',
    translationKey: FailureTranslationKeys.firebaseInvalidCredential,
  ),

  'invalid-email' => FirebaseFailure(
    message: error.message ?? 'Email format is invalid.',
    translationKey: FailureTranslationKeys.firebaseInvalidEmail,
  ),

  'missing-email' => FirebaseFailure(
    message: error.message ?? 'Email is missing.',
    translationKey: FailureTranslationKeys.firebaseMissingEmail,
  ),

  'operation-not-allowed' => FirebaseFailure(
    message: error.message ?? 'Operation not allowed.',
    translationKey: FailureTranslationKeys.firebaseOperationNotAllowed,
  ),

  'requires-recent-login' => FirebaseFailure(
    message: error.message ?? 'Please re-authenticate.',
    translationKey: FailureTranslationKeys.firebaseRequiresRecentLogin,
  ),

  'too-many-requests' => FirebaseFailure(
    message: error.message ?? 'Too many attempts. Please try again later.',
    translationKey: FailureTranslationKeys.firebaseTooManyRequests,
  ),

  'user-disabled' => FirebaseFailure(
    message: error.message ?? 'Account is disabled.',
    translationKey: FailureTranslationKeys.firebaseUserDisabled,
  ),

  'user-not-found' => FirebaseFailure(
    message: error.message ?? 'No user found with this email.',
    translationKey: FailureTranslationKeys.firebaseUserNotFound,
  ),

  'weak-password' => FirebaseFailure(
    message: error.message ?? 'Password is too weak.',
    translationKey: FailureTranslationKeys.firebaseWeakPassword,
  ),

  'wrong-password' => FirebaseFailure(
    message: error.message ?? 'Incorrect password.',
    translationKey: FailureTranslationKeys.firebaseWrongPassword,
  ),

  _ => FirebaseFailure(
    message: error.message ?? 'Firebase error occurred.',
    translationKey: FailureTranslationKeys.firebaseGeneric,
  ),
};

////

////

/// 🧊 [_handleFirebaseAuth] — edge-case handler for [FirebaseAuthException].
/// ✅ Covers missing user, disabled accounts, and all other fallbacks.
//
Failure _handleFirebaseAuth(FirebaseAuthException error) =>
    _handleFirebase(error);
