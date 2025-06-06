import 'dart:async' show FutureOr;
import 'package:flutter/material.dart';
import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/either_for_data/either_extensions/_eithers_facade.dart';
import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/loggers_for_errors_handling_module/failure_logger_x.dart';
import '../../failures_for_domain_and_presentation/failure_for_domain.dart';

/// 🧩 [DSLLikeResultHandler<T>] — wrapper for `Either<Failure, T>`
/// ✅ Clean, chainable result handling with both sync & async APIs
/// ✅ Unified for use in Providers, Cubits, UseCases, UI, etc.
//────────────────────────────────────────────────────────────────────────

@immutable
final class DSLLikeResultHandler<T> {
  final Either<Failure, T> result;
  const DSLLikeResultHandler(this.result);

  //──────────────────────────────────────────────────────────────────────
  // 🔹 Success / Failure Callbacks (SYNC)
  //──────────────────────────────────────────────────────────────────────

  /// 🔹 Executes [handler] if result is success (sync)
  DSLLikeResultHandler<T> onSuccess(void Function(T value) handler) {
    if (result.isRight) handler(result.rightOrNull as T);
    return this;
  }

  /// 🔹 Executes [handler] if result is failure (sync)
  DSLLikeResultHandler<T> onFailure(void Function(Failure failure) handler) {
    if (result.isLeft) handler(result.leftOrNull!);
    return this;
  }

  //──────────────────────────────────────────────────────────────────────
  // 🔹 Success / Failure Callbacks (ASYNC)
  //──────────────────────────────────────────────────────────────────────

  /// 🔹 Executes [handler] if result is success (async)
  Future<DSLLikeResultHandler<T>> onSuccessAsync(
    FutureOr<void> Function(T value) handler,
  ) async {
    if (result.isRight) await handler(result.rightOrNull as T);
    return this;
  }

  /// 🔹 Executes [handler] if result is failure (async)
  Future<DSLLikeResultHandler<T>> onFailureAsync(
    FutureOr<void> Function(Failure failure) handler,
  ) async {
    if (result.isLeft) await handler(result.leftOrNull!);
    return this;
  }

  //──────────────────────────────────────────────────────────────────────
  // 🔁 Fold Logic
  //──────────────────────────────────────────────────────────────────────

  /// 🔁 Pattern match logic (sync)
  void fold({
    required void Function(Failure failure) onFailure,
    required void Function(T value) onSuccess,
  }) {
    result.fold(onFailure, onSuccess);
  }

  /// 🔁 Pattern match logic (async)
  Future<void> foldAsync({
    required FutureOr<void> Function(Failure failure) onFailure,
    required FutureOr<void> Function(T value) onSuccess,
  }) async {
    await result.fold(onFailure, onSuccess);
  }

  //──────────────────────────────────────────────────────────────────────
  // 🎯 Accessors
  //──────────────────────────────────────────────────────────────────────

  /// ✅ Returns success value or fallback
  T getOrElse(T fallback) => result.fold((_) => fallback, (r) => r);

  /// ✅ Nullable success
  T? get valueOrNull => result.rightOrNull;

  /// ❌ Nullable failure
  Failure? get failureOrNull => result.leftOrNull;

  /// ✅ Indicates if result is failure
  bool get didFail => result.isLeft;

  /// ✅ Indicates if result is success
  bool get didSucceed => result.isRight;

  //──────────────────────────────────────────────────────────────────────
  // 🧪 Logging
  //──────────────────────────────────────────────────────────────────────

  /// 🐞 Logs failure (debug or Crashlytics)
  DSLLikeResultHandler<T> log() {
    result.leftOrNull?.log();
    return this;
  }

  /// 🐞 Logs failure (async)
  Future<DSLLikeResultHandler<T>> logAsync() async {
    result.leftOrNull?.log();
    return this;
  }

  ///
}
