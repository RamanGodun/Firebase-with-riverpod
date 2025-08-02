import 'dart:async' show TimeoutException;
import 'dart:convert' show JsonUnsupportedObjectError;
import 'dart:io' show FileSystemException, HttpException, SocketException;
import 'package:dio/dio.dart' show DioException, DioExceptionType;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:firebase_core/firebase_core.dart' show FirebaseException;
import 'package:flutter/services.dart'
    show MissingPluginException, PlatformException;
import '../utils/errors_observing/loggers/errors_log_util.dart';
import 'failure_entity.dart';
import '../extensible_part/failure_source.dart';
import '../extensible_part/failure_translation_keys.dart';

part '../extensible_part/exceptions_to_failures_mapper_x.dart';
part '../extensible_part/exceptions_to_failures_mapping/dio_cases.dart';
part '../extensible_part/exceptions_to_failures_mapping/firebase_cases.dart';
part '../extensible_part/exceptions_to_failures_mapping/network_cases.dart';
part '../extensible_part/exceptions_to_failures_mapping/platform_cases.dart';
part '../extensible_part/exceptions_to_failures_mapping/domain_cases.dart';

/// 🧰 [ExceptionToFailureMapper] — centralized converter for raw exceptions to domain-level [Failure].
/// ✅ Converts ASTRODES into structured [Failure] types.
//
final class ExceptionToFailureMapper {
  ///------------------------------
  const ExceptionToFailureMapper._();

  /// 🛡️ Converts any caught error into domain-level [Failure].
  static Failure from(dynamic error, [StackTrace? stackTrace]) {
    //
    ErrorsLogger.log(error, stackTrace);
    //
    if (error is Failure) return error; // ! 🧼 Already mapped — passthrough
    //
    return error.mapToFailure();
    //
  }
}
