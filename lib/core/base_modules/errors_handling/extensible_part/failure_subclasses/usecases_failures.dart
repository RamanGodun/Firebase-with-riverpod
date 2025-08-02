part of '../../core_of_module/failure_entity.dart';

/// 🧠 [UseCaseFailure] — validation / business logic violation
//
final class UseCaseFailure extends Failure {
  ///---------------------------------------
  //
  UseCaseFailure({
    required super.message,
    FailureTranslationKeys translationKey =
        FailureTranslationKeys.useCaseInvalidArgument,
  }) : super._(
         statusCode: FailureSource.useCase.code,
         code: 'USE_CASE',
         translationKey: translationKey.translationKey,
       );
  //
}

////

/// Failure, when email verification polling time is expired
//
final class EmailVerificationFailure extends Failure {
  ///--------------------------------------------
  //
  EmailVerificationFailure.timeoutExceeded()
    : super._(
        message: 'Email verification polling timed out.',
        translationKey:
            FailureTranslationKeys.emailVerificationTimeout.translationKey,
        code: 'EMAIL_VERIFICATION_TIMEOUT',
        statusCode: FailureSource.useCase.code,
      );

  //
}
