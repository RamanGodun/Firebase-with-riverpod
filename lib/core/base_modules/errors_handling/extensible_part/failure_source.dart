/// 🔌 [FailureSource] — Identifies the source of a [Failure].
/// 🧭 Used for diagnostics, analytics, and telemetry mapping.
//
enum FailureSource {
  ///
  // 🌐 HTTP / Dio / Socket / Timeout / Legacy HTTP
  httpClient,
  // 🔥 Firebase Core / Auth / Firestore / Firebase plugins
  firebase,
  // 🧊 SQLite / local DBs (not used yet)
  sqlite,
  // 🧠 Domain logic validation / ArgumentError
  useCase,
  // ⌛ Email verification polling failure
  emailVerification,
  // 💾 SharedPrefs, disk I/O, file read/write
  cache,
  // ⚙️ Platform plugin errors / MissingPlugin / Format / JSON
  platform,
  // ❓ Catch-all fallback for unrecognized failures
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
