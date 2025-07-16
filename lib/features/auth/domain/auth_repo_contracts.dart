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

////

////

/// 🔓 [ISignOutRepo] — contract for signing out the user
/// 🧼 Abstracts sign-out method used across use cases

abstract interface class ISignOutRepo {
  ///----------------------------------
  //
  // 🔓 Signs out the currently authenticated user
  Future<void> signOut();
  //
}

////

////

/// 🆕 [ISignUpRepo] — contract for user registration logic
/// 🧼 Abstracts Firebase sign-up + Firestore user doc creation

abstract interface class ISignUpRepo {
  ///--------------------------------
  //
  // 🆕 Creates a new user and stores additional info in Firestore
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  });
  //
}
