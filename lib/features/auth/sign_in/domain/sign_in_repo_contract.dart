library;

/// 🔐 [ISignInRepo] — contract for signing in user with email/password
/// 🧼 Abstracts sign-in method used across use cases

abstract interface class ISignInRepo {
  ///---------------------------------
  //
  // 🔐 Signs user in using provided credentials
  Future<void> signIn({required String email, required String password});
  //
}
