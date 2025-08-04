part of '../../core_of_module/failure_type.dart';

/// 🎯 [failure_type_firebase.dart] — Firebase-related FailureTypes
/// 📦 Includes Auth & Firestore Firebase-related codes

/// 🔥 Firebase Generic fallback
final class GenericFirebaseFT extends FailureType {
  const GenericFirebaseFT()
    : super(
        code: 'FIREBASE',
        translationKey: LocaleKeys.failures_firebase_generic,
      );
}

/// 🔐 Firebase Auth Errors
final class InvalidCredentialFirebaseFT extends FailureType {
  const InvalidCredentialFirebaseFT()
    : super(
        code: 'INVALID_CREDENTIAL',
        translationKey: LocaleKeys.failures_firebase_invalid_credential,
      );
}

final class AccountExistsWithDifferentCredentialFirebaseFT extends FailureType {
  const AccountExistsWithDifferentCredentialFirebaseFT()
    : super(
        code: 'ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL',
        translationKey:
            LocaleKeys
                .failures_firebase_account_exists_with_different_credential,
      );
}

final class EmailAlreadyInUseFirebaseFT extends FailureType {
  const EmailAlreadyInUseFirebaseFT()
    : super(
        code: 'EMAIL_ALREADY_IN_USE',
        translationKey: LocaleKeys.failures_firebase_email_already_in_use,
      );
}

final class OperationNotAllowedFirebaseFT extends FailureType {
  const OperationNotAllowedFirebaseFT()
    : super(
        code: 'OPERATION_NOT_ALLOWED',
        translationKey: LocaleKeys.failures_firebase_operation_not_allowed,
      );
}

final class UserDisabledFirebaseFT extends FailureType {
  const UserDisabledFirebaseFT()
    : super(
        code: 'USER_DISABLED',
        translationKey: LocaleKeys.failures_firebase_user_disabled,
      );
}

final class UserNotFoundFirebaseFT extends FailureType {
  const UserNotFoundFirebaseFT()
    : super(
        code: 'USER_NOT_FOUND',
        translationKey: LocaleKeys.failures_firebase_user_not_found,
      );
}

final class RequiresRecentLoginFirebaseFT extends FailureType {
  const RequiresRecentLoginFirebaseFT()
    : super(
        code: 'REQUIRES_RECENT_LOGIN',
        translationKey: LocaleKeys.failures_firebase_requires_recent_login,
      );
}

final class UserMissingFirebaseFT extends FailureType {
  const UserMissingFirebaseFT()
    : super(
        code: 'FIREBASE_USER_MISSING',
        translationKey: LocaleKeys.failures_firebase_no_current_user,
      );
}

final class DocMissingFirebaseFT extends FailureType {
  const DocMissingFirebaseFT()
    : super(
        code: 'FIRESTORE_DOC_MISSING',
        translationKey: LocaleKeys.failures_firebase_doc_missing,
      );
}

final class TooManyRequestsFirebaseFT extends FailureType {
  const TooManyRequestsFirebaseFT()
    : super(
        code: 'TOO_MANY_REQUESTS',
        translationKey: LocaleKeys.failures_firebase_too_many_requests,
      );
}
