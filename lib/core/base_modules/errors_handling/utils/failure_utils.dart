import '../failures/failure_model.dart';
import 'exceptions_to_failures_mapper/_exceptions_to_failures_mapper.dart';
import '../either/either.dart';

/// 🧰 [FailureUtils] — shortcut helpers for converting errors into [Failure]s.
/// ✅ Single entry point for mapping any error/exception to a [Failure] object.
/// ✅ Used in ResultFuture, use cases, and async flows.
//
Failure mapToFailure(dynamic error, [StackTrace? stack]) =>
    ExceptionToFailureMapper.from(error, stack);

////

/// ✅ [right] — Helper for creating a successful result in the `Either` monad.
/// Used for returning success values from use cases and repository methods.
//
Right<Failure, T> right<T>(T value) => Right(value);

////

/// ❌ [left] — Helper for wrapping a [Failure] into an `Either.left`.
/// Used for returning errors in a functional way, propagating failures explicitly.
//
Left<Failure, T> left<T>(Failure failure) => Left(failure);
