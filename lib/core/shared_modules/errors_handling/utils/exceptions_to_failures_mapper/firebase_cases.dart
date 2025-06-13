part of '_exceptions_to_failures_mapper.dart';

/// 🔥 [_handleFirebase] — maps [FirebaseException] to structured [Failure]s.
/// ✅ Handles auth-related and general Firebase error codes.

Failure _handleFirebase(FirebaseException error) => switch (error.code) {
  //
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

  _ => FirebaseFailure(
    message: error.message ?? 'Firebase error occurred.',
    translationKey: FailureKeys.firebaseGeneric,
  ),
};

/// 🧊 [_handleFirebaseAuth] — edge-case handler for [FirebaseAuthException].
/// ✅ Used when user is disabled or missing in auth context.

Failure _handleFirebaseAuth(FirebaseAuthException error) => switch (error
    .code) {
  //
  'user-disabled' => FirebaseUserMissingFailure(),

  _ => FirebaseFailure(
    message: error.message ?? 'Firebase Auth error.',
    translationKey: FailureKeys.firebaseGeneric,
  ),

  //
};
