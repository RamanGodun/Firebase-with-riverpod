import '../../failures/failure_entity.dart';
import '../failure_mapper.dart';
import '../../either/either.dart';

/// 🧩 [mapToFailure] — shorthand alias for `FailureMapper.from(...)`
/// ✅ Used in all `ResultFuture` blocks and use cases
Failure mapToFailure(dynamic error, [StackTrace? stack]) =>
    FailureMapper.from(error, stack);

Right<Failure, T> right<T>(T value) => Right(value);
Left<Failure, T> left<T>(Failure failure) => Left(failure);
