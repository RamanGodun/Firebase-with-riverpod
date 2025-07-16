library;

/// 🧼 Contract for email verification and user reload operations
//
abstract interface class IUserValidationRepo {
  ///-----------------------------------------
  //
  // 📧 Sends verification email to current user
  Future<void> sendEmailVerification();
  // 🔁 Reloads the current user's state from Firebase
  Future<void> reloadUser();
  // ✅ Checks if the user's email is verified
  bool isEmailVerified();
  //
}
