library;

/// 🧼 Contract for password-related operations with user account
//
abstract interface class IPasswordRepo {
  ///---------------------------------
  //
  /// 📩 Sends password reset link to the given email
  Future<void> sendResetLink(String email);
  //
  /// 🔁 Changes the password for the currently signed-in user
  Future<void> changePassword(String newPassword);
  //
}
