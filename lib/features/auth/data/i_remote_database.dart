// /// 🔐 [IAuthRemoteDataSource] — contract for auth operations
// /// 🧼 Abstracts low-level Remote Database calls for sign-in / sign-up / sign-out
// //
// abstract interface class IAuthRemoteDataSource {
//   ///----------------------------------------
//   //
//   /// 🔐 Signs in Remote Database
//   Future<void> signIn({required String email, required String password});

//   /// 🆕 Creates new user in Remote Database
//   Future<UserCredential> signUp({
//     required String email,
//     required String password,
//   });

//   /// 💾 Save User in Remote Database
//   Future<void> saveUserDTO(UserDTO dto);

//   /// 🔓 Signs out current user
//   Future<void> signOut();
// }

/// 🔐 [IAuthRemoteDataSource] — contract for auth operations
/// 🧼 Abstracts low-level Remote Database calls for sign-in / sign-up / sign-out
//
abstract interface class IAuthRemoteDataSource {
  ///----------------------------------------
  //
  /// Authenticates user by email and password.
  Future<void> signIn({required String email, required String password});

  /// Registers new user and returns [userID] (or credentials map, or id).
  Future<String> signUp({required String email, required String password});

  /// Saves user data (as [Map]) in remote DB by [uid].
  Future<void> saveUserData(String uid, Map<String, dynamic> userData);

  /// Signs out current user in remote DB.
  Future<void> signOut();
}
///----------------------------------------