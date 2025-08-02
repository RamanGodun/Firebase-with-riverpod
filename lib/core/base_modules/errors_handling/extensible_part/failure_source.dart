/// 🔌 [FailureSource] — Identifies the source of a [CustomError].
/// 🧭 Useful for analytics, diagnostics, and categorizing error origins.
//
enum FailureSource {
  ///-----------
  //
  httpClient,
  firebase,
  sqlite,
  useCase,
  emailVerification,
  cache,
  platform,
  unknown;

  /// 📦 Code used in logs and telemetry (e.g. 'FIREBASE')
  String get code => switch (this) {
    httpClient => 'HTTP_CLIENT',
    firebase => 'FIREBASE',
    sqlite => 'SQLITE',
    useCase => 'USE_CASE',
    emailVerification => 'EMAIL_VERIFICATION',
    cache => 'CACHE',
    platform => 'PLATFORM',
    unknown => 'UNKNOWN',
  };

  //
}
