import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../utils/typedef.dart';
import '../../../failures_for_domain_and_presentation/failure_for_domain.dart';
import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/failures_for_domain_and_presentation/failure_x.dart';
import 'dart:async';

/// 🧩 [ResultNotifier<T>] — async wrapper for `ResultFuture<T>`
/// ✅ Handles [Either<Failure, T>] into `AsyncValue<T?>`
class ResultNotifier<T> extends AsyncNotifier<T?> {
  @override
  FutureOr<T?> build() => null;

  Future<void> foldAsync(
    ResultFuture<T> future, {
    FutureOr<void> Function(Failure failure)? onFailure,
    FutureOr<void> Function(T value)? onSuccess,
  }) async {
    state = const AsyncLoading();

    final either = await future;

    await either.fold(
      (f) async => await onFailure?.call(f),
      (v) async => await onSuccess?.call(v),
    );

    state = either.fold(
      (f) => AsyncError(f.toUIModel(), StackTrace.current),
      (v) => AsyncData(v),
    );
  }

  /// 🔁 Reset state to initial
  void reset() => state = const AsyncData(null);

  /// 🧼 Clear failure, preserving value
  void clearFailure() {
    if (state.hasError) {
      state = AsyncData(state.valueOrNull);
    }
  }

  //
}
