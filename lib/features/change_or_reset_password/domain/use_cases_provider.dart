import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils_shared/type_definitions.dart';
import '../data/data_layer_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'repo_contract.dart';

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

////

////

/// 📦 [PasswordRelatedUseCases] — encapsulates password related logic
/// 🧼 Handles Firebase logic with failure mapping
//
final class PasswordRelatedUseCases {
  ///-----------------------------

  final IPasswordRepo repo;
  const PasswordRelatedUseCases(this.repo);

  /// 🔁 Triggers password change and wraps result
  ResultFuture<void> callChangePassword(String newPassword) =>
      repo.changePassword(newPassword);

  /// 📩 Sends reset link to the provided email
  ResultFuture<void> callResetPassword(String email) =>
      repo.sendResetLink(email);

  //
}
