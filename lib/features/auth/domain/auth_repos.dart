/// 🧼 Contract for changing the user password
//----------------------------------------------------------------
abstract interface class IChangePasswordRepo {
  // 🔁 Changes the password for the currently signed-in user
  // Throws [FirebaseAuthException] if no user is signed in
  Future<void> changePassword(String newPassword);
}

///

/// 🧼 Contract for email verification and user reload operations
//----------------------------------------------------------------
abstract interface class IEmailVerificationRepo {
  // 📧 Sends verification email to current user
  Future<void> sendEmailVerification();
  // 🔁 Reloads the current user's state from Firebase
  Future<void> reloadUser();
  // ✅ Checks if the user's email is verified
  bool isEmailVerified();
}

///

/// 🧼 Contract for sending password reset link to user email
//----------------------------------------------------------------
abstract interface class IResetPasswordRepo {
  // 📩 Sends password reset link to given email
  Future<void> sendResetLink(String email);
}

///

/// 🔐 [ISignInRepo] — contract for signing in user with email/password
/// 🧼 Abstracts sign-in method used across use cases
//----------------------------------------------------------------
abstract interface class ISignInRepo {
  // 🔐 Signs user in using provided credentials
  Future<void> signIn({required String email, required String password});
}

///

/// 🔓 [ISignOutRepo] — contract for signing out the user
/// 🧼 Abstracts sign-out method used across use cases
//----------------------------------------------------------------
abstract interface class ISignOutRepo {
  // 🔓 Signs out the currently authenticated user
  Future<void> signOut();
}

///

/// 🆕 [ISignUpRepo] — contract for user registration logic
/// 🧼 Abstracts Firebase sign-up + Firestore user doc creation
//----------------------------------------------------------------
abstract interface class ISignUpRepo {
  // 🆕 Creates a new user and stores additional info in Firestore
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  });
}
