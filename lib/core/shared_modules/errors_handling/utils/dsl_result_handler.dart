import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/either_for_data/either_x/_eithers_facade.dart';
import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/loggers_for_errors_handling_module/failure_logger_x.dart';
import 'package:flutter/material.dart';
import '../failures_for_domain_and_presentation/failure_for_domain.dart';

/// 🧩 [ResultHandler<T>] — wrapper around `Either<Failure, T>`
/// ✅ Clean, chainable, and readable result API for Cubits, Providers, UseCases.
@immutable
final class DSLLikeResultHandler<T> {
  final Either<Failure, T> result;
  const DSLLikeResultHandler(this.result);

  // ──────────────────────────────────────────────────────────────────────
  // 🔹 Success / Failure Callbacks
  // ──────────────────────────────────────────────────────────────────────

  /// 🔹 Executes handler if result is success
  DSLLikeResultHandler<T> onSuccess(void Function(T value) handler) {
    if (result.isRight) handler(result.rightOrNull as T);
    return this;
  }

  /// 🔹 Executes handler if result is failure
  DSLLikeResultHandler<T> onFailure(void Function(Failure failure) handler) {
    if (result.isLeft) handler(result.leftOrNull!);
    return this;
  }

  // ──────────────────────────────────────────────────────────────────────
  // 🎯 Accessors & Info
  // ──────────────────────────────────────────────────────────────────────

  /// ✅ Success value or fallback
  T getOrElse(T fallback) => result.fold((_) => fallback, (r) => r);

  /// ✅ Nullable success
  T? get valueOrNull => result.rightOrNull;

  /// ❌ Nullable failure
  Failure? get failureOrNull => result.leftOrNull;

  /// ✅ Indicates if result is failure
  bool get didFail => result.isLeft;

  /// ✅ Indicates if result is success
  bool get didSucceed => result.isRight;

  // ──────────────────────────────────────────────────────────────────────
  // 🔁 Fold Logic
  // ──────────────────────────────────────────────────────────────────────

  /// 🔁 Pattern match logic
  void fold({
    required void Function(Failure failure) onFailure,
    required void Function(T value) onSuccess,
  }) {
    result.fold(onFailure, onSuccess);
  }

  // ──────────────────────────────────────────────────────────────────────
  // 🧪 Logging
  // ──────────────────────────────────────────────────────────────────────

  /// 🐞 Logs failure (debug or Crashlytics)
  DSLLikeResultHandler<T> log() {
    result.leftOrNull?.log();
    return this;
  }

  ///
}
