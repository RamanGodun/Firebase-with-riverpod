import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/providers/data_layer_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../password_actions_use_case.dart';

part 'use_cases_provider.g.dart';

/// 🧩 [passwordUseCasesProvider] — provides instance of [PasswordRelatedUseCases]
/// 🧼 Depends on [passwordRepoProvider] for implementation
//
@riverpod
PasswordRelatedUseCases passwordUseCases(Ref ref) {
  ///─────------------------------------------------
  //
  final repo = ref.watch(passwordRepoProvider);
  return PasswordRelatedUseCases(repo);
  //
}
