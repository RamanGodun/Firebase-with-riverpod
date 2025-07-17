import '../../../core/utils_shared/shared_auth/auth_user_utils.dart';

/// 🛰️ [IUserValidationRemoteDataSource] — abstract contract for remote data base
/// 🧱 Defines low-level user auth operations
//
abstract interface class IUserValidationRemoteDataSource {
  ///--------------------------------------------------
  //
  /// 📧 Sends verification email to current user
  Future<void> sendVerificationEmail();

  /// 🔁 Reloads current user from FirebaseAuth
  Future<void> reloadUser();

  /// ✅ Returns whether current user's email is verified
  bool isEmailVerified();
  //
}

////

////

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
