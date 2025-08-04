part of '../../core_of_module/failure_type.dart';

final class NetworkFailureType extends FailureType {
  const NetworkFailureType()
    : super(code: 'NETWORK', translationKey: 'failure.network.no_connection');
}

final class JsonErrorFailureType extends FailureType {
  const JsonErrorFailureType()
    : super(code: 'JSON_ERROR', translationKey: 'failure.format.error');
}

final class ApiFailureType extends FailureType {
  const ApiFailureType()
    : super(code: 'API', translationKey: 'failure.api.generic');
}

final class NetworkTimeoutFailureType extends FailureType {
  const NetworkTimeoutFailureType()
    : super(code: 'TIMEOUT', translationKey: 'failure.network.timeout');
}
