part of '../../core_of_module/failure_entity.dart';

/// ⏱️ [TimeoutFailure] — request took too long or didn't complete in time
/// ✅ Useful for detecting and retrying slow network / API conditions
//
final class TimeoutFailure extends Failure {
  ///---------------------------------------
  //
  TimeoutFailure({
    required super.message,
    FailureTranslationKeys translationKey = FailureTranslationKeys.timeout,
  }) : super._(
         statusCode: FailureSource.httpClient.code,
         code: 'TIMEOUT',
         translationKey: translationKey.translationKey,
       );
  //
}
