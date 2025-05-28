import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/config/firebase/firebase_constants.dart';

part 'change_password_repo.g.dart';

/// 🧩 [changePasswordRepoProvider] — provides concrete repo impl
//--------------------------------------------------------------
@riverpod
IChangePasswordRepo changePasswordRepo(Ref ref) => ChangePasswordRepoImpl();

abstract interface class IChangePasswordRepo {
  Future<void> changePassword(String newPassword);
}

final class ChangePasswordRepoImpl implements IChangePasswordRepo {
  @override
  Future<void> changePassword(String newPassword) async {
    final user = fbAuth.currentUser;
    if (user == null) throw FirebaseAuthException(code: 'no-current-user');
    await user.updatePassword(newPassword);
  }
}
