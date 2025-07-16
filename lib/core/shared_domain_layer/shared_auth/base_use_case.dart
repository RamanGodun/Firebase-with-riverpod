import '../../base_modules/errors_handling/either/either.dart';
import '../../base_modules/errors_handling/failures/failure_model.dart';
import '../../base_modules/errors_handling/utils/failure_utils.dart';

/// [BaseUseCase] - Abstract base class for use case implementations.
/// Provides a consistent method to wrap any async domain logic
/// and convert errors into [Failure] types for safe functional error handling.

abstract class BaseUseCase {
  /// -------------------
  //
  /// Executes a given async operation and returns an [Either] type.
  /// On success: returns [Right] with the result.
  /// On error: maps the exception to a [Failure] and returns [Left].
  Future<Either<Failure, T>> executeSafely<T>(
    Future<T> Function() operation,
  ) async {
    try {
      final result = await operation();
      return right(result);
    } catch (e, st) {
      return left(mapToFailure(e, st));
    }
  }
}

/// [ResultFutureExtension] - Extension for async function types.
/// Provides a declarative way to wrap any async operation
/// with failure mapping and functional error handling.

extension ResultFutureExtension<T> on Future<T> Function() {
  //
  /// Executes the function, returning [Right] on success,
  /// or [Left] with mapped [Failure] on error.
  Future<Either<Failure, T>> executeWithFailureHandling() async {
    try {
      final result = await this();
      return right(result);
    } catch (e, st) {
      return left(mapToFailure(e, st));
    }
  }
}
