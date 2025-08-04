part of '../../core_of_module/failure_type.dart';

final class PlatformFailureType extends FailureType {
  const PlatformFailureType()
    : super(code: 'PLATFORM', translationKey: 'failure.format.error');
}

final class FormatErrorFailureType extends FailureType {
  const FormatErrorFailureType()
    : super(code: 'FORMAT_ERROR', translationKey: 'failure.format.error');
}

final class MissingPluginFailureType extends FailureType {
  const MissingPluginFailureType()
    : super(code: 'MISSING_PLUGIN', translationKey: 'failure.plugin.missing');
}

final class SqliteFailureType extends FailureType {
  const SqliteFailureType()
    : super(code: 'SQLITE', translationKey: 'failure.cache.error');
}
