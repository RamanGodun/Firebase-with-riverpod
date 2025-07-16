import '../base_modules/errors_handling/utils/observers/loggers/errors_log_util.dart';

/// [BaseRepo] - Abstract base class for all repository implementations.
/// Provides a utility method to wrap async repository logic
/// with consistent error logging and rethrowing.

abstract class BaseRepo {
  /// -----------------
  //
  Future<T> runSafely<T>(Future<T> Function() action) async {
    try {
      return await action();
    } catch (e, st) {
      ErrorsLogger.log(e, st);
      rethrow; // Rethrows the original exception after logging.
    }
  }
}

/// [SafeExecution] - Extension for async function types.
/// Provides a convenient, declarative way to wrap any repository method
/// with error logging and propagation.

extension SafeExecution<T> on Future<T> Function() {
  //
  Future<T> runWithErrorLog() async {
    try {
      return await this();
    } catch (e, st) {
      ErrorsLogger.log(e, st);
      rethrow; // Rethrows the original exception after logging.
    }
  }
}
