import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../utils/typedef.dart';
import '../../../either_for_data/either.dart';
import '../../../failures_for_domain_and_presentation/failure_for_domain.dart';
import '../../../failures_for_domain_and_presentation/failure_ui_model.dart';
import '../../consumable.dart';
import 'result_notifier_provider.dart';
import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/failures_for_domain_and_presentation/to_ui_failures_x.dart';
import 'dart:async';

/// 🧩 [AsyncResultNotifierRefX] — adds `.runVoid()` to WidgetRef
extension AsyncResultNotifierRefX on WidgetRef {
  //
  /// 🔁 For void-results (submit, logout, etc)
  Future<void> runResultVoid(
    ResultFuture<void> future, {
    void Function(Failure)? onFailure,
    void Function()? onSuccess,
  }) async {
    final notifier = read(asyncResultNotifierProvider<void>().notifier);
    await notifier.foldAsync(
      future,
      onFailure: onFailure,
      onSuccess: (_) => onSuccess?.call(),
    );
  }

  /// 🔁 For typified results `T`
  Future<void> runResult<T>(
    ResultFuture<T> future, {
    void Function(Failure)? onFailure,
    void Function(T data)? onSuccess,
  }) async {
    final notifier = read(asyncResultNotifierProvider<T>().notifier);
    await notifier.foldAsync(
      future,
      onFailure: onFailure,
      onSuccess: onSuccess,
    );
  }
}

///
extension ResultFutureHandlerX<T> on ResultFuture<T> {
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

extension EitherToAsyncValueX<T> on Either<Failure, T> {
  AsyncValue<T> toAsyncValue() => fold(
    (f) => AsyncError(f.toUIModel(), StackTrace.current),
    (v) => AsyncData(v),
  );
}
