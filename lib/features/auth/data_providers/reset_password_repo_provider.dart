import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/app_configs/firebase/firebase_constants.dart';
import '../domain/auth_repos.dart';

part 'reset_password_repo_provider.g.dart';

/// 🧩 [resetPasswordRepoProvider] — provides instance of [ResetPasswordRepoImpl]
/// 🧼 Dependency injection for password reset functionality
@riverpod
IResetPasswordRepo resetPasswordRepo(Ref ref) => ResetPasswordRepoImpl();

///----------------------------------------------------------------------------
/// 🧩 [ResetPasswordRepoImpl] — concrete implementation of [IResetPasswordRepo]
/// 🧼 Uses FirebaseAuth to send reset email
final class ResetPasswordRepoImpl implements IResetPasswordRepo {
  @override
  Future<void> sendResetLink(String email) async {
    await fbAuth.sendPasswordResetEmail(email: email);
  }
}
