import '../utils/enums.dart';
import '../failures_for_domain_and_presentation/failure_for_domain.dart';

/// 🧭 [FailureDiagnosticsX] — Diagnostic utilities for `Failure`
/// ✅ Includes type checkers, casting, logging helpers, and fallback-safe metadata access.
/// ✅ Used in logging, Crashlytics, result handlers, and advanced failure branching.
// ──────────────────────────────────────────────────────────────────────

extension FailureDiagnosticsX on Failure {
  /// 🔌 Source & Type Diagnostics

  /// Returns plugin source identifier (used in logs, analytics, crash reports)
  String get pluginSource => switch (this) {
    GenericFailure() => statusCode?.toString() ?? ErrorPlugin.unknown.code,
    ApiFailure() => ErrorPlugin.httpClient.code,
    FirebaseFailure() => ErrorPlugin.firebase.code,
    UseCaseFailure() => ErrorPlugin.useCase.code,
    UnauthorizedFailure() => 'AUTH',
    CacheFailure() => 'CACHE',
    _ => ErrorPlugin.unknown.code,
  };

  /// Safe type-cast of the current failure to a specific subtype
  T? as<T extends Failure>() => this is T ? this as T : null;

  /// Returns non-null error code (for logs, identifiers)
  String get safeCode => code ?? 'UNKNOWN_CODE';

  /// Returns stringified status (e.g. HTTP or plugin code)
  String get safeStatus => statusCode?.toString() ?? 'NO_STATUS';

  /// Developer-friendly label combining code and message
  String get label => '$safeCode — $message';

  //
}
