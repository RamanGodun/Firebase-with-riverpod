library;

/// 🆕 [ISignUpRepo] — contract for user registration logic
/// 🧼 Abstracts Firebase sign-up + Firestore user doc creation

abstract interface class ISignUpRepo {
  //---------------------------------

  // 🆕 Creates a new user and stores additional info in Firestore
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  });

  //
}
