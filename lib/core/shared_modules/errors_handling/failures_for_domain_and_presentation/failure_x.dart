import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/loggers_for_errors_handling_module/failure_diagnostics_x.dart';
import 'package:flutter/material.dart';
import '../../localization/code_base_for_both_options/_app_localizer.dart';
import 'enums.dart';
import 'failure_for_domain.dart';
import '../utils/for_bloc/consumable.dart';
import 'failure_ui_model.dart';

/// ✅ [FailureToUIModelX] — Maps [Failure] to [FailureUIModel] without localization context
extension FailureToUIModelX on Failure {
  //
  FailureUIModel toUIModel() {
    final resolvedText =
        (translationKey?.isNotEmpty ?? false)
            ? AppLocalizer.t(translationKey!, fallback: message)
            : message;

    return FailureUIModel(
      localizedMessage: resolvedText,
      formattedCode: safeCode,
      icon: _resolveIcon(),
    );
  }

  // 🖼️ Internal: Icon depending on failure type
  IconData _resolveIcon() => switch (this) {
    ApiFailure() => Icons.cloud_off,
    FirebaseFailure() => Icons.fireplace,
    UseCaseFailure() => Icons.settings,
    GenericFailure(:final plugin) => switch (plugin) {
      ErrorPlugin.httpClient => Icons.wifi_off,
      ErrorPlugin.firebase => Icons.fire_extinguisher,
      ErrorPlugin.useCase => Icons.build,
      _ => Icons.error_outline,
    },
    UnauthorizedFailure() => Icons.lock,
    NetworkFailure() => Icons.signal_wifi_connected_no_internet_4,
    CacheFailure() => Icons.sd_storage,
    _ => Icons.error_outline,
  };

  // 🎯 One-shot wrapper for state management
  Consumable<FailureUIModel> asConsumableUIModel() => Consumable(toUIModel());
}

///

/// 🧭 [FailureTypeX] — Semantic helpers for `Failure` type branching
/// ✅ Replaces `is SomeFailure` with readable intent
/// ✅ Improves clarity in conditional logic (UI/logic branching)
// ─────────────────────────────────────────────────────────────
extension FailureTypeX on Failure {
  /// ❌ True if failure is due to lack of network or timeout
  bool get isNetwork => this is NetworkFailure;

  /// 🔒 True if failure was caused by unauthorized access (401)
  bool get isUnauthorized => this is UnauthorizedFailure;

  /// 🔥 True if failure originated from Firebase layer
  bool get isFirebase => this is FirebaseFailure;

  /// 💾 True if failure is from local cache or preferences
  bool get isCache => this is CacheFailure;

  /// 🌐 True if failure is HTTP-level (non-auth)
  bool get isApi => this is ApiFailure;

  /// ❓ True if failure is uncategorized or fallback
  bool get isUnknown => this is UnknownFailure;

  /// ⚙️ True if failure was caused by a plugin/platform system issue
  bool get isPlatform => this is GenericFailure;

  /// 🧠 True if failure occurred in business/use-case logic
  bool get isUseCase => this is UseCaseFailure;
}
