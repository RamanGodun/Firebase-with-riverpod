part of '../../core_of_module/_run_errors_handling.dart';

/// ⚙️ [_handlePlatform] — maps [PlatformException] to [GenericFailure].
/// ✅ Used for native platform channel errors.
//
Failure _handlePlatform(PlatformException error) => GenericFailure(
  plugin: FailureSource.useCase,
  code: error.code,
  message: error.message ?? 'Platform error occurred.',
  translationKey: FailureTranslationKeys.formatError,
);

////
////

/// 📦 [_handleMissingPlugin] — maps [MissingPluginException] to [GenericFailure].
/// ✅ Indicates an unregistered or unavailable platform plugin.
//
Failure _handleMissingPlugin(MissingPluginException error) => GenericFailure(
  plugin: FailureSource.useCase,
  code: 'MISSING_PLUGIN',
  message: error.message ?? 'Plugin not initialized.',
  translationKey: FailureTranslationKeys.missingPlugin,
);

////
////

/// 🧾 [_handleFormat] — maps [FormatException] to [GenericFailure].
/// ✅ Used when malformed data is encountered (non-JSON).
//
Failure _handleFormat(FormatException error) => GenericFailure(
  plugin: FailureSource.unknown,
  code: 'FORMAT_ERROR',
  message: 'Malformed data received.',
  translationKey: FailureTranslationKeys.formatError,
);

////
////

/// 🧬 [_handleJson] — maps [JsonUnsupportedObjectError] to [GenericFailure].
/// ✅ Indicates issues serializing non-supported JSON types.
//
Failure _handleJson(JsonUnsupportedObjectError error) => GenericFailure(
  plugin: FailureSource.unknown,
  code: 'JSON_ERROR',
  message: 'Unsupported JSON: ${error.cause}',
  translationKey: FailureTranslationKeys.formatError,
);
