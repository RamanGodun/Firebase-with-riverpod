import 'package:flutter/material.dart';
import '../../core_of_module/failure_type.dart';

/// 🎨 [FailureIconX] — Declaratively maps [FailureType] to an [IconData]
/// ✅ Keeps UI concerns out of domain-layer entities
/// ✅ Declares logic directly on instance
extension FailureIconX on FailureType {
  /// 🎨 [icon] — Resolves icon based on concrete [FailureType]
  IconData get icon {
    if (this is NetworkFailureType)
      return Icons.signal_wifi_connected_no_internet_4;
    if (this is NetworkTimeoutFailureType) return Icons.schedule;
    if (this is GenericFirebaseFT) return Icons.local_fire_department;
    if (this is UserMissingFirebaseFT) return Icons.no_accounts;
    if (this is DocMissingFirebaseFT) return Icons.insert_drive_file;
    if (this is UnauthorizedFailureType) return Icons.lock;
    if (this is CacheFailureType) return Icons.sd_storage;
    if (this is UseCaseFailureType) return Icons.settings;
    if (this is EmailVerificationFailureType) return Icons.mark_email_read;
    if (this is EmailVerificationTimeoutFailureType)
      return Icons.mark_email_unread;
    if (this is FormatErrorFailureType) return Icons.format_align_justify;
    if (this is JsonErrorFailureType) return Icons.code;
    if (this is MissingPluginFailureType) return Icons.extension_off;
    if (this is ApiFailureType) return Icons.cloud_off;
    if (this is SqliteFailureType) return Icons.storage;
    if (this is PlatformFailureType) return Icons.memory;
    if (this is UnknownFailureType) return Icons.error_outline;
    if (this is EmailAlreadyInUseFirebaseFT) return Icons.mark_email_read;
    if (this is UserNotFoundFirebaseFT) return Icons.person_search;
    if (this is UserDisabledFirebaseFT) return Icons.block;
    if (this is EmailAlreadyInUseFirebaseFT) return Icons.mail_lock;
    if (this is OperationNotAllowedFirebaseFT) return Icons.do_not_disturb_alt;

    ///
    return Icons.error; // 🔒 Fallback UI icon
  }
}
