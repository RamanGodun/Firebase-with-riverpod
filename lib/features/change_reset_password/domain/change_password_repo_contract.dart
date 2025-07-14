library;

/// 🧼 Contract for changing the user password
abstract interface class IChangePasswordRepo {
  ///--------------------------------------------
  //
  // 🔁 Changes the password for the currently signed-in user
  Future<void> changePassword(String newPassword);
  //
}
