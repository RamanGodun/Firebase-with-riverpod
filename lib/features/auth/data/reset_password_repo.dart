import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/config/firebase/firebase_constants.dart';

part 'reset_password_repo.g.dart';

@riverpod
IResetPasswordRepo resetPasswordRepo(Ref ref) => ResetPasswordRepoImpl();

abstract interface class IResetPasswordRepo {
  Future<void> sendResetLink(String email);
}

final class ResetPasswordRepoImpl implements IResetPasswordRepo {
  @override
  Future<void> sendResetLink(String email) async {
    await fbAuth.sendPasswordResetEmail(email: email);
  }
}
