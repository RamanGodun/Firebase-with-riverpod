library;

/// 🔓 [ISignOutRepo] — contract for signing out the user
/// 🧼 Abstracts sign-out method used across use cases

abstract interface class ISignOutRepo {
  //----------------------------------

  // 🔓 Signs out the currently authenticated user
  Future<void> signOut();

  //
}
