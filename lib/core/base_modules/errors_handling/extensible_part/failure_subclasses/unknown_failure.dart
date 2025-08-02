part of '../../core_of_module/failure_entity.dart';

/// ❓ [UnknownFailure] — unhandled, uncategorized fallback
//
final class UnknownFailure extends Failure {
  ///---------------------------------------
  //
  UnknownFailure({
    required super.message,
    FailureTranslationKeys translationKey = FailureTranslationKeys.unknown,
  }) : super._(
         statusCode: 'UNKNOWN',
         translationKey: translationKey.translationKey,
       );
  //
}
