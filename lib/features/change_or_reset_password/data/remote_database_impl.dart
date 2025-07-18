import '../../../app_bootstrap_and_config/app_config/firebase/firebase_constants.dart';
import '../../../core/utils_shared/shared_auth/auth_user_utils.dart';
import 'i_remote_database.dart';

/// 🧩 [PasswordRemoteDataSourceImpl] — Firebase-based implementation of [IPasswordRemoteDataSource]
/// ✅ Handles actual communication with [FirebaseAuth]
//
final class PasswordRemoteDataSourceImpl implements IPasswordRemoteDataSource {
  ///-----------------------------------------------------------------------
  //
  @override
  Future<void> changePassword(String newPassword) async {
    final user = AuthUserUtils.currentUserOrThrow;
    await user.updatePassword(newPassword);
  }

  @override
  Future<void> sendResetLink(String email) async {
    await fbAuth.sendPasswordResetEmail(email: email);
  }

  //
}
