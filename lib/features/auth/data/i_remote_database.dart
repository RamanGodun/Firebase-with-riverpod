import 'package:firebase_auth/firebase_auth.dart';

import '../../profile/data/data_transfer_objects/_user_dto.dart';

/// 🔐 [IAuthRemoteDataSource] — contract for auth operations
/// 🧼 Abstracts low-level Remote Database calls for sign-in / sign-up / sign-out
//
abstract interface class IAuthRemoteDataSource {
  ///----------------------------------------
  //
  /// 🔐 Signs in Remote Database
  Future<void> signIn({required String email, required String password});

  /// 🆕 Creates new user in Remote Database
  Future<UserCredential> signUp({
    required String email,
    required String password,
  });

  /// 💾 Save User in Remote Database
  Future<void> saveUserDTO(UserDTO dto);

  /// 🔓 Signs out current user
  Future<void> signOut();
}
