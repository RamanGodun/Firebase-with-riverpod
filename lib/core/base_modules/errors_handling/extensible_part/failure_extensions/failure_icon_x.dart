import 'package:flutter/material.dart' show IconData, Icons;
import '../../core_of_module/failure_entity.dart';
import '../failure_source.dart';

/// 🖼️ Icon depending on failure type
//
extension FailureIconX on Failure {
  IconData get getIcon => switch (this) {
    ApiFailure() => Icons.cloud_off,
    NetworkFailure() => Icons.signal_wifi_connected_no_internet_4,
    TimeoutFailure() => Icons.schedule,
    UnauthorizedFailure() => Icons.lock,
    CacheFailure() => Icons.sd_storage,
    UseCaseFailure() => Icons.settings,
    EmailVerificationFailure() => Icons.mark_email_read,
    FirebaseUserMissingFailure() => Icons.no_accounts,
    FirestoreDocMissingFailure() => Icons.insert_drive_file,
    FirebaseFailure() => Icons.fireplace,
    GenericFailure(:final plugin) => switch (plugin) {
      FailureSource.httpClient => Icons.wifi_off,
      FailureSource.firebase => Icons.fire_extinguisher,
      FailureSource.platform => Icons.memory,
      _ => Icons.extension,
    },
    _ => Icons.error_outline,
  };
}
