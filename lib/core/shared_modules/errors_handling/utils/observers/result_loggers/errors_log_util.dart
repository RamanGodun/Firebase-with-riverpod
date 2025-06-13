import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/utils/observers/failure_diagnostics_x.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import '../../../failures/failure_entity.dart';

/// 🧭 [ErrorsLoggerUtil] — Centralized logger for all application-level telemetry.
/// 🔍 Supports runtime exceptions and domain-level failures

abstract final class ErrorsLoggerUtil {
  const ErrorsLoggerUtil._();
  //------------------

  /// ❗ Logs any raw [Exception] or [Error].
  static void exception(Object error, [StackTrace? stackTrace]) {
    debugPrint('[Exception] ${error.runtimeType}: $error');
    if (stackTrace case final trace?) debugPrint(trace.toString());
  }

  /// 🧱 Logs a domain-level [Failure].
  static void failure(Failure failure, [StackTrace? stackTrace]) {
    debugPrint('[Failure] ${failure.label}');
    if (stackTrace case final trace?) debugPrint(trace.toString());
  }

  static void log(Object error, [StackTrace? stackTrace]) {
    ErrorsLoggerUtil.exception(error, stackTrace);
  }

  //
}
