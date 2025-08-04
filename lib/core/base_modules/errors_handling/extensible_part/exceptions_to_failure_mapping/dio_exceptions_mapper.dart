part of '../../core_of_module/_run_errors_handling.dart';

/// 🧩 [_mapDioError] — maps [DioException] to specific [Failure]s
/// ✅ Handles timeouts, HTTP errors, and default cases
Failure _mapDioError(DioException error) => switch (error.type) {
  // ⏱️ Timeout-related Dio errors
  DioExceptionType.connectionTimeout ||
  DioExceptionType.receiveTimeout ||
  DioExceptionType.sendTimeout => FailureFactory.timeout,

  // 📡 HTTP response errors
  DioExceptionType.badResponse => switch (error.response?.statusCode) {
    final code? when code == 401 => FailureFactory.unauthorized,
    final code? when code >= 400 && code < 600 => FailureFactory.api(code),
    _ => FailureFactory.api(error.response?.statusCode ?? 0),
  },

  // ❗ All other Dio cases
  _ => FailureFactory.network(message: error.message),
};
