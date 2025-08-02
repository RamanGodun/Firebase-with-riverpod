import '../../core_of_module/either.dart';
import '../../core_of_module/failure_entity.dart';

extension FailureToEitherX on Failure {
  /// ❌ Converts this [Failure] into an `Either.left`
  Left<Failure, T> toLeft<T>() => Left(this);
}
