import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/utils/observers/failure_diagnostics_x.dart';
import 'package:flutter/material.dart';
import '../../../localization/code_base_for_both_options/_app_localizer.dart';
import '../../utils/observers/loggers/errors_log_util.dart';
import '../../enums/error_plugins.dart';
import '../failure_entity.dart';
import '../../utils/for_bloc/consumable.dart';
import '../failure_ui_entity.dart';

/// ✅ [FailureToUIEntityX] — Maps [Failure] to [FailureUIEntity] without localization context
extension FailureToUIEntityX on Failure {
  //

  /// From [Failure] to [FailureUIEntity] mapper
  FailureUIEntity toUIEntity() {
    //
    final resolvedText = switch ((
      translationKey?.isNotEmpty,
      message.isNotEmpty,
    )) {
      (true, true) => AppLocalizer.t(translationKey!, fallback: message),
      (true, false) => AppLocalizer.t(translationKey!),
      _ => message,
    };

    if (translationKey != null && resolvedText == message) {
      ErrorsLogger.failure(this, StackTrace.current);
    }

    return FailureUIEntity(
      localizedMessage: resolvedText,
      formattedCode: safeCode,
      icon: _resolveIcon(),
    );
  }

  // 🖼️ Icon depending on failure type
  IconData _resolveIcon() => switch (this) {
    ApiFailure() => Icons.cloud_off,
    FirebaseFailure() => Icons.fireplace,
    UseCaseFailure() => Icons.settings,
    GenericFailure(:final plugin) => switch (plugin) {
      ErrorPlugins.httpClient => Icons.wifi_off,
      ErrorPlugins.firebase => Icons.fire_extinguisher,
      ErrorPlugins.useCase => Icons.build,
      _ => Icons.error_outline,
    },
    UnauthorizedFailure() => Icons.lock,
    NetworkFailure() => Icons.signal_wifi_connected_no_internet_4,
    CacheFailure() => Icons.sd_storage,
    _ => Icons.error_outline,
  };

  // 🎯 Wrapper for "one-shot" state management
  Consumable<FailureUIEntity> asConsumableUIEntity() =>
      Consumable(toUIEntity());

  //
}
