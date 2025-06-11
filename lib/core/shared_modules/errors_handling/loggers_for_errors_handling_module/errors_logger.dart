import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/loggers_for_errors_handling_module/failure_diagnostics_x.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import '../failures_for_domain_and_presentation/failure_for_domain.dart';

/// 🧭 [ErrorsLogger] — Centralized logger for all application-level telemetry.
/// 🔍 Supports runtime exceptions and domain-level failures
///-----------------------------------------------------------------------------

abstract final class ErrorsLogger {
  const ErrorsLogger._();

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
    ErrorsLogger.exception(error, stackTrace);
  }

  //
}
