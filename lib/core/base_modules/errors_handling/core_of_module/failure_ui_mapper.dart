import 'package:firebase_with_riverpod/core/base_modules/errors_handling/extensible_part/failure_extensions/failure_diagnostics_x.dart';
import 'package:firebase_with_riverpod/core/base_modules/errors_handling/extensible_part/failure_extensions/failure_icon_x.dart';
import '../../localization/core_of_module/init_localization.dart';
import '../utils/errors_observing/loggers/errors_log_util.dart';
import 'failure_entity.dart';
import 'failure_ui_entity.dart';

/// ✅ [FailureToUIEntityX] — Maps [Failure] to [FailureUIEntity]
//
extension FailureToUIEntityX on Failure {
  ///---------------------------------
  //
  /// From [Failure] to [FailureUIEntity] mapper
  FailureUIEntity toUIEntity() {
    //
    final resolvedText = switch ((
      translationKey?.isNotEmpty,
      message.isNotEmpty,
    )) {
      (true, true) => AppLocalizer.translateSafely(
        translationKey!,
        fallback: message,
      ),
      (true, false) => AppLocalizer.translateSafely(translationKey!),
      _ => message,
    };
    //
    if (translationKey != null && resolvedText == message) {
      ErrorsLogger.failure(this, StackTrace.current);
    }
    //
    return FailureUIEntity(
      localizedMessage: resolvedText,
      formattedCode: safeCode,
      icon: getIcon,
    );
  }

  //
}
