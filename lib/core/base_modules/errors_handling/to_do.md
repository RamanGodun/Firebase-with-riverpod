


// ✅ 3. FailureToUIEntityX — треба розширити _resolveIcon:
///
/// Додати іконки для всіх типів, які ще не обробляються:
/// - CacheFailure => Icons.sd_storage (вже є)
/// - TimeoutFailure => Icons.timer_outlined (немає)
/// - UnknownFailure => Icons.device_unknown (можна краще)
/// - EmailVerificationFailure => Icons.email_outlined (немає)
/// - GenericFailure => інші плагіни не мапляться на іконки


// ✅ 4. Заповнити code/statusCode/translationKey в усіх сабкласах [Failure]
///
/// 🔍 Виявлено:
/// - ApiFailure: statusCode є, але translationKey -> завжди unknown ❌
/// - CacheFailure: translationKey -> always unknown ❌
/// - UseCaseFailure: translationKey -> unknown ❌
/// - GenericFailure: не завжди вказується code (напр., _handleFormat)

/// 🧠 РЕКОМЕНДАЦІЯ:
/// - Винести `code`, `statusCode` і `translationKey` у factory-конструктори / helper-и, щоб не дублювати значення в кожному сабкласі


// ✅ 5. FailureTypeX / FailureDiagnosticsX — назви схожі, але мають різні цілі
/// РЕКОМЕНДАЦІЯ:
/// - залишити обидва, але додати в README різницю: один — semantic getters, інший — diagnostics for logging


// ✅ 6. ExceptionToFailureMapper
/// - 👍 Прекрасно структуровано по `_handleX` методах
/// - 🔥 Треба уніфікувати поля code/plugin/statusCode в кожному з них (де не заповнені)
///
/// Наприклад:
/// ```dart
/// GenericFailure(
///   plugin: ErrorPlugins.platform,
///   code: error.code ?? 'PLATFORM_UNKNOWN',
///   ...
/// )
/// ```


// ✅ 7. Додати мета-функцію `Failure.debugDescribe()`
/// Наприклад:
/// ```dart
/// extension DebugFailureX on Failure {
///   String debugDescribe() => '[${safeCode}] $message';
/// }
/// ```


// ✅ 8. README.md: потрібен розділ "How to add new failure plugin"
/// з поясненням, як додати новий тип failure (exception => failure => translation => icon => plugin)
