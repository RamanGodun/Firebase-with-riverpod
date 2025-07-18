import '../../../core/utils_shared/shared_auth/auth_user_utils.dart';
import 'i_remote_database.dart';

/// 🛠️ [IUserValidationRemoteDataSourceImpl] — Firebase-powered implementation
/// 🚫 No failure mapping — pure infrastructure logic
//
final class IUserValidationRemoteDataSourceImpl
    implements IUserValidationRemoteDataSource {
  ///----------------------------------------
  //
  @override
  Future<void> sendVerificationEmail() async {
    final user = AuthUserUtils.currentUserOrThrow;
    await user.sendEmailVerification();
  }

  @override
  Future<void> reloadUser() async {
    final user = AuthUserUtils.currentUserOrThrow;
    await user.reload();
  }

  @override
  bool isEmailVerified() {
    return AuthUserUtils.currentUserOrThrow.emailVerified;
  }

  //
}
