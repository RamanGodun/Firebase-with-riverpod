part of '../../core_of_module/failure_type.dart';

// 📦 [failure_type_misc.dart] — Generic, logic or application-level failures
// ❓ Everything that doesn’t fall under specific system/platform source
//
final class UnknownFailureType extends FailureType {
  const UnknownFailureType()
    : super(code: 'UNKNOWN', translationKey: 'failure.unknown');
}

final class CacheFailureType extends FailureType {
  const CacheFailureType()
    : super(code: 'CACHE', translationKey: 'failure.cache.error');
}

final class UnauthorizedFailureType extends FailureType {
  const UnauthorizedFailureType()
    : super(code: 'UNAUTHORIZED', translationKey: 'failure.auth.unauthorized');
}

final class UseCaseFailureType extends FailureType {
  const UseCaseFailureType()
    : super(
        code: 'USE_CASE',
        translationKey: 'failure.use_case.invalid_argument',
      );
}

final class EmailVerificationFailureType extends FailureType {
  const EmailVerificationFailureType()
    : super(
        code: 'EMAIL_VERIFICATION',
        translationKey: 'failure.email_verification.timeout',
      );
}

final class EmailVerificationTimeoutFailureType extends FailureType {
  const EmailVerificationTimeoutFailureType()
    : super(
        code: 'EMAIL_VERIFICATION_TIMEOUT',
        translationKey: 'failure.email_verification.timeout',
      );
}
