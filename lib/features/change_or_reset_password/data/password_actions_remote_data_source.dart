import '../../../app_bootstrap_and_config/app_config/firebase/firebase_constants.dart';
import '../../../core/shared_domain_layer/shared_auth/auth_user_utils.dart';

abstract interface class IPasswordRemoteDataSource {
  Future<void> changePassword(String newPassword);
  Future<void> sendResetLink(String email);
}

////

////

final class PasswordRemoteDataSourceImpl
    implements IPasswordRemoteDataSource {

  @override
  Future<void> changePassword(String newPassword) async {
    final user = AuthUserUtils.currentUserOrThrow;
    await user.updatePassword(newPassword);
  }

  @override
  Future<void> sendResetLink(String email) async {
    await fbAuth.sendPasswordResetEmail(email: email);
  }
}