part of '_exceptions_to_failures_mapper.dart';

/// 🔥 [_handleFirebase] — maps [FirebaseException] to structured [Failure]s.
/// ✅ Handles all major Firebase error codes with localization support.

Failure _handleFirebase(FirebaseException error) => switch (error.code) {
  'invalid-credential' => FirebaseFailure(
    message: error.message ?? 'Invalid credentials.',
    translationKey: FailureKeys.firebaseInvalidCredential,
  ),
  'user-not-found' => FirebaseFailure(
    message: error.message ?? 'No user found with this email.',
    translationKey: FailureKeys.firebaseUserNotFound,
  ),
  'wrong-password' => FirebaseFailure(
    message: error.message ?? 'Incorrect password.',
    translationKey: FailureKeys.firebaseWrongPassword,
  ),
  'invalid-email' => FirebaseFailure(
    message: error.message ?? 'Email format is invalid.',
    translationKey: FailureKeys.firebaseInvalidEmail,
  ),
  'missing-email' => FirebaseFailure(
    message: error.message ?? 'Email is missing.',
    translationKey: FailureKeys.firebaseMissingEmail,
  ),
  'too-many-requests' => FirebaseFailure(
    message: error.message ?? 'Too many attempts. Please try again later.',
    translationKey: FailureKeys.firebaseTooManyRequests,
  ),
  _ => FirebaseFailure(
    message: error.message ?? 'Firebase error occurred.',
    translationKey: FailureKeys.firebaseGeneric,
  ),
};

///

/// 🧊 [_handleFirebaseAuth] — edge-case handler for [FirebaseAuthException].
/// ✅ Covers missing user, disabled accounts, and all other fallbacks.

Failure _handleFirebaseAuth(FirebaseAuthException error) =>
    _handleFirebase(error);
