import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/app_configs/firebase/firebase_constants.dart';
import '../domain/auth_repos.dart';

part 'change_password_repo_provider.g.dart';

/// 🧩 [changePasswordRepoProvider] — provides instance of [ChangePasswordRepoImpl]
/// 🧼 Dependency injection for changing password functionality
@riverpod
IChangePasswordRepo changePasswordRepo(Ref ref) => ChangePasswordRepoImpl();

///-------------------------------------------------------------------------------
/// 🧩 [ChangePasswordRepoImpl] — concrete implementation of [IChangePasswordRepo]
/// 🧼 Uses FirebaseAuth to update password for the current user
final class ChangePasswordRepoImpl implements IChangePasswordRepo {
  @override
  Future<void> changePassword(String newPassword) async {
    final user = fbAuth.currentUser;
    if (user == null) {
      throw FirebaseAuthException(code: 'no-current-user');
    }

    await user.updatePassword(newPassword);
  }
}
