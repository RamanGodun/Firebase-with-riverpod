import 'package:flutter/material.dart';

part '../extensible_part/failure_types/firebase.dart';
part '../extensible_part/failure_types/network.dart';
part '../extensible_part/failure_types/platform.dart';
part '../extensible_part/failure_types/misc.dart';

/// 💡 [FailureType] — Centralized descriptor for domain failures
/// ✅ Contains i18n translation key, unique code, and extensibility
//
@immutable
sealed class FailureType {
  ///------------------
  //
  final String code;
  final String translationKey;
  //
  const FailureType({required this.code, required this.translationKey});
}
