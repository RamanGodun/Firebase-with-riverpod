import 'package:flutter/material.dart' show IconData, Icons;
import '../../core_of_module/failure_entity.dart';
import '../failure_source.dart';

/// 🖼️ Icon depending on failure type
//
extension FailureIconX on Failure {
  IconData get getIcon => switch (this) {
    ApiFailure() => Icons.cloud_off,
    FirebaseFailure() => Icons.fireplace,
    UseCaseFailure() => Icons.settings,
    GenericFailure(:final plugin) => switch (plugin) {
      FailureSource.httpClient => Icons.wifi_off,
      FailureSource.firebase => Icons.fire_extinguisher,
      _ => Icons.error_outline,
    },
    UnauthorizedFailure() => Icons.lock,
    NetworkFailure() => Icons.signal_wifi_connected_no_internet_4,
    CacheFailure() => Icons.sd_storage,
    _ => Icons.error_outline,
  };
}
