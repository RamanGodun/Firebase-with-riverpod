import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/typedef.dart';
import '../../failures_for_domain_and_presentation/failure_for_domain.dart';
import 'result_notifier_provider.dart';
import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/failures_for_domain_and_presentation/to_ui_failures_x.dart';
import '../../failures_for_domain_and_presentation/failure_ui_model.dart';
import '../consumable.dart';
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

/// 🧩 [ResultNotifierRefX] — adds `.runVoid()` to WidgetRef
extension ResultNotifierRefX on WidgetRef {
  //
  /// 🔁 For void-results (submit, logout, etc)
  Future<void> runVoid(
    ResultFuture<void> future, {
    void Function(Failure)? onFailure,
    void Function()? onSuccess,
  }) async {
    final notifier = read(resultNotifierProvider<void>().notifier);
    await notifier.foldAsync(
      future,
      onFailure: onFailure,
      onSuccess: (_) => onSuccess?.call(),
    );
  }

  /// 🔁 For typized results `T`
  Future<void> runWith<T>(
    ResultFuture<T> future, {
    void Function(Failure)? onFailure,
    void Function(T data)? onSuccess,
  }) async {
    final notifier = read(resultNotifierProvider<T>().notifier);
    await notifier.foldAsync(
      future,
      onFailure: onFailure,
      onSuccess: onSuccess,
    );
  }
}

///
extension ResultFutureX<T> on ResultFuture<T> {
  Future<T> guardAndConsume({
    required void Function(Consumable<FailureUIModel>) onFailure,
  }) async {
    final result = await this;

    return result.fold((f) {
      onFailure(f.toUIModel().asConsumable());
      throw f;
    }, (data) => data);
  }
}
