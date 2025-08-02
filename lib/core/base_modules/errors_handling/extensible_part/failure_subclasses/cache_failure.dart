part of '../../core_of_module/failure_entity.dart';

/// 🧊 [CacheFailure] — local storage, preferences, or disk read/write error
//
final class CacheFailure extends Failure {
  ///---------------------------------------
  //
  CacheFailure({
    required super.message,
    FailureTranslationKeys translationKey = FailureTranslationKeys.cacheError,
  }) : super._(
         statusCode: FailureSource.cache.code,
         code: 'CACHE',
         translationKey: translationKey.translationKey,
       );
  //
}
