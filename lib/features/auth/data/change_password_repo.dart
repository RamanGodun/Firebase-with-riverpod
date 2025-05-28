import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/config/firebase/firebase_constants.dart';

part 'change_password_repo.g.dart';

/// 🧩 [changePasswordRepoProvider] — provides concrete repo impl
//--------------------------------------------------------------
@riverpod
IChangePasswordRepo changePasswordRepo(Ref ref) => ChangePasswordRepoImpl();

abstract interface class IChangePasswordRepo {
  Future<void> changePassword(String password);
}

final class ChangePasswordRepoImpl implements IChangePasswordRepo {
  @override
  Future<void> changePassword(String password) async {
    await fbAuth.currentUser!.updatePassword(password);
  }
}
