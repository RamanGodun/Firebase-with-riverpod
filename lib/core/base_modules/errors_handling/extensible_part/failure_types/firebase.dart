part of '../../core_of_module/failure_type.dart';

// 🎯 [failure_type_firebase.dart] — Firebase-related FailureTypes
// 📦 Includes Auth & generic Firebase-related codes

// 🔐 Firebase Auth Errors (based on official Firebase docs)
final class InvalidCredentialFirebaseFT extends FailureType {
  const InvalidCredentialFirebaseFT()
    : super(
        code: 'INVALID_CREDENTIAL',
        translationKey: 'failure.firebase.invalid_credential',
      );
}

final class AccountExistsWithDifferentCredentialFirebaseFT extends FailureType {
  const AccountExistsWithDifferentCredentialFirebaseFT()
    : super(
        code: 'ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL',
        translationKey:
            'failure.firebase.account_exists_with_different_credential',
      );
}

final class EmailAlreadyInUseFirebaseFT extends FailureType {
  const EmailAlreadyInUseFirebaseFT()
    : super(
        code: 'EMAIL_ALREADY_IN_USE',
        translationKey: 'failure.firebase.email_in_use',
      );
}

final class WeakPasswordFirebaseFT extends FailureType {
  const WeakPasswordFirebaseFT()
    : super(
        code: 'WEAK_PASSWORD',
        translationKey: 'failure.firebase.weak_password',
      );
}

final class OperationNotAllowedFirebaseFT extends FailureType {
  const OperationNotAllowedFirebaseFT()
    : super(
        code: 'OPERATION_NOT_ALLOWED',
        translationKey: 'failure.firebase.operation_not_allowed',
      );
}

final class UserDisabledFirebaseFT extends FailureType {
  const UserDisabledFirebaseFT()
    : super(
        code: 'USER_DISABLED',
        translationKey: 'failure.firebase.user_disabled',
      );
}

final class UserNotFoundFirebaseFT extends FailureType {
  const UserNotFoundFirebaseFT()
    : super(
        code: 'USER_NOT_FOUND',
        translationKey: 'failure.firebase.user_not_found',
      );
}

////

// 🔐 Firebase Email verification & linking (based on official Firebase docs)
final class RequiresRecentLoginFirebaseFT extends FailureType {
  const RequiresRecentLoginFirebaseFT()
    : super(
        code: 'REQUIRES_RECENT_LOGIN',
        translationKey: 'failure.firebase.requires_recent_login',
      );
}

final class ExpiredActionCodeFirebaseFT extends FailureType {
  const ExpiredActionCodeFirebaseFT()
    : super(
        code: 'EXPIRED_ACTION_CODE',
        translationKey: 'failure.firebase.expired_action_code',
      );
}

final class InvalidVerificationCodeFirebaseFT extends FailureType {
  const InvalidVerificationCodeFirebaseFT()
    : super(
        code: 'INVALID_VERIFICATION_CODE',
        translationKey: 'failure.firebase.invalid_verification_code',
      );
}

final class InvalidVerificationIdFirebaseFT extends FailureType {
  const InvalidVerificationIdFirebaseFT()
    : super(
        code: 'INVALID_VERIFICATION_ID',
        translationKey: 'failure.firebase.invalid_verification_id',
      );
}

final class UserMismatchFailureType extends FailureType {
  const UserMismatchFailureType()
    : super(
        code: 'USER_MISMATCH',
        translationKey: 'failure.firebase.user_mismatch',
      );
}

// 🔥 Firebase Generic fallback (based on official Firebase docs)
final class FirebaseFailureType extends FailureType {
  const FirebaseFailureType()
    : super(code: 'FIREBASE', translationKey: 'failure.firebase.generic');
}

// 🔐 Internal Firebase edge cases
final class FirebaseUserMissingFailureType extends FailureType {
  const FirebaseUserMissingFailureType()
    : super(
        code: 'FIREBASE_USER_MISSING',
        translationKey: 'failure.firebase.no_current_user',
      );
}

final class FirebaseUserNotFoundFailureType extends FailureType {
  const FirebaseUserNotFoundFailureType()
    : super(
        code: 'FIREBASE_USER_NOT_FOUND',
        translationKey: 'failure.firebase.user_not_found',
      );
}

final class FirestoreDocMissingFailureType extends FailureType {
  const FirestoreDocMissingFailureType()
    : super(
        code: 'FIRESTORE_DOC_MISSING',
        translationKey: 'failure.firebase.doc_missing',
      );
}

final class FirestoreNotFoundFailureType extends FailureType {
  const FirestoreNotFoundFailureType()
    : super(
        code: 'FIRESTORE_NOT_FOUND',
        translationKey: 'failure.firestore.not_found',
      );
}

final class FirestorePermissionDeniedFailureType extends FailureType {
  const FirestorePermissionDeniedFailureType()
    : super(
        code: 'FIRESTORE_PERMISSION_DENIED',
        translationKey: 'failure.firestore.permission_denied',
      );
}

final class FirestoreUnavailableFailureType extends FailureType {
  const FirestoreUnavailableFailureType()
    : super(
        code: 'FIRESTORE_UNAVAILABLE',
        translationKey: 'failure.firestore.unavailable',
      );
}

final class FirestoreDeadlineExceededFailureType extends FailureType {
  const FirestoreDeadlineExceededFailureType()
    : super(
        code: 'FIRESTORE_DEADLINE_EXCEEDED',
        translationKey: 'failure.firestore.timeout',
      );
}

final class FirestoreAbortedFailureType extends FailureType {
  const FirestoreAbortedFailureType()
    : super(
        code: 'FIRESTORE_ABORTED',
        translationKey: 'failure.firestore.aborted',
      );
}

final class FirestoreUnauthenticatedFailureType extends FailureType {
  const FirestoreUnauthenticatedFailureType()
    : super(
        code: 'FIRESTORE_UNAUTHENTICATED',
        translationKey: 'failure.firebase.requires_recent_login',
      );
}

final class FirebaseTooManyRequestsFailureType extends FailureType {
  const FirebaseTooManyRequestsFailureType()
    : super(
        code: 'TOO_MANY_REQUESTS',
        translationKey: 'failure.firebase.too_many_requests',
      );
}
