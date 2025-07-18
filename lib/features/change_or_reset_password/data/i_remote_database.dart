/// 📡 [IPasswordRemoteDataSource] — contract for low-level password operations
/// ✅ Abstracts infrastructure layer (e.g., Firebase)
//
abstract interface class IPasswordRemoteDataSource {
  ///--------------------------------------------
  //
  /// 🔁 Updates password of the currently signed-in user
  Future<void> changePassword(String newPassword);

  /// 📩 Sends reset link to given email
  Future<void> sendResetLink(String email);
}
