import 'package:firebase_auth/firebase_auth.dart' show UserCredential;
import 'package:firebase_with_riverpod/features/profile/data/data_transfer_objects/user_dto_x.dart';
import '../../../app_bootstrap_and_config/app_config/firebase/firebase_constants.dart';
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

////

////

/// 🛠️ [AuthRemoteDataSourceImpl] — Firebase-powered implementation
/// 🧱 Directly performs Firebase Auth operations
//
final class AuthRemoteDataSourceImpl implements IAuthRemoteDataSource {
  ///---------------------------------------------------------------
  //
  /// 🔐 Firebase sign-in
  @override
  Future<void> signIn({required String email, required String password}) async {
    await fbAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  /// 🆕 Firebase sign-up
  @override
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    return fbAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// 💾 Save User in Firestore
  @override
  Future<void> saveUserDTO(UserDTO dto) {
    return usersCollection.doc(dto.id).set(dto.toJsonMap());
  }

  /// 🔓 Firebase sign-out
  @override
  Future<void> signOut() async {
    await fbAuth.signOut();
  }

  //
}
