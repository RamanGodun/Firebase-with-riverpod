library;

/// 🧼 Contract for sending password reset link to user email

abstract interface class IResetPasswordRepo {
  //------------------------------------------

  // 📩 Sends password reset link to given email
  Future<void> sendResetLink(String email);

  //
}
