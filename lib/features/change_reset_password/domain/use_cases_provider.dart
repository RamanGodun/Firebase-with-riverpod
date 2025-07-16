import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/password_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'use_cases.dart';

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
