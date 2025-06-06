import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/loggers_for_errors_handling_module/failure_diagnostics_x.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import '../../failures_for_domain_and_presentation/failure_for_domain.dart';
import '../../loggers_for_errors_handling_module/errors_logger.dart';
import '_eithers_facade.dart';

/// 🧩 [ResultX<T>] — Sync sugar for `Either<Failure, T>`
/// ✅ Enables fallback values, failure access, and folding logic
//-------------------------------------------------------------------------

extension ResultX<T> on Either<Failure, T> {
  /// 🔁 Match (fold) sync logic — now chainable
  /// ✅ Auto-logs failure and tracks success
  Either<Failure, T> match({
    required void Function(Failure failure) onFailure,
    required void Function(T value) onSuccess,
    String? successTag,
    StackTrace? stack,
  }) {
    fold(
      (f) {
        ErrorsLogger.failure(f, stack);
        onFailure(f);
      },
      (r) {
        final tag = successTag ?? 'Success';
        debugPrint('[SUCCESS][$tag] $r');
        onSuccess(r);
      },
    );
    return this;
  }

  /// 🎯 Returns value or fallback
  T getOrElse(T fallback) => fold((_) => fallback, (r) => r);

  /// 🧼 Returns failure message or null
  String? get failureMessage => fold((f) => f.message, (_) => null);

  /// 🔁 Maps right value
  Either<Failure, R> mapRight<R>(R Function(T value) transform) =>
      mapRight(transform);

  /// 🔁 Maps left value
  Either<Failure, T> mapLeft(Failure Function(Failure failure) transform) =>
      mapLeft(transform);

  /// 🔍 True if failure is Unauthorized
  bool get isUnauthorizedFailure => switch (this) {
    Left(:final value) => value.safeCode == 'UNAUTHORIZED',
    Right() => false,
  };

  /// 🔁 Emits state changes declaratively
  void emitStates({
    void Function()? emitLoading,
    required void Function(Failure) emitFailure,
    required void Function(T) emitSuccess,
  }) {
    emitLoading?.call();
    fold(emitFailure, emitSuccess);
  }

  ///
}
