import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:firebase_with_riverpod/features/profile/data/data_transfer_objects/user_dto_x.dart';
import '../../../../app_bootstrap_and_config/app_config/firebase/firebase_constants.dart';
import '../../../../core/base_modules/errors_handling/utils/observers/loggers/errors_log_util.dart';
import '../../profile/data/data_transfer_objects/user_dto_factories_x.dart';
import '../domain/auth_repo_contracts.dart';

/// 🧩 [SignInRepoImpl] — concrete implementation of [ISignInRepo]
/// 🧼 Wraps [FirebaseAuth.signInWithEmailAndPassword]

final class SignInRepoImpl implements ISignInRepo {
  ///---------------------------------------------

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      await fbAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e, st) {
      ErrorsLogger.log(e, st);
      rethrow;
    }
  }

  //
}

////

////

/// 🧩 [SignOutRepoImpl] — concrete implementation of [ISignOutRepo]
/// 🧼 Wraps [FirebaseAuth.signOut] with error logging

final class SignOutRepoImpl implements ISignOutRepo {
  ///-----------------------------------------------

  @override
  Future<void> signOut() async {
    try {
      await fbAuth.signOut();
    } catch (e, st) {
      ErrorsLogger.log(e, st);
      rethrow;
    }
  }

  //
}

////

////

/// 🤩 [SignUpRepoImpl] — concrete implementation of [ISignUpRepo]
/// 🧼 Wraps [FirebaseAuth.createUserWithEmailAndPassword] + Firestore

final class SignUpRepoImpl implements ISignUpRepo {
  ///---------------------------------------------

  @override
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await fbAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user!;

      // ✅ Create DTO
      final dto = UserDTOFactories.newUser(
        id: user.uid,
        name: name,
        email: email,
      );

      // 💾 Save in Firestore
      await usersCollection.doc(user.uid).set(dto.toJsonMap());
    } on FirebaseAuthException catch (e, st) {
      ErrorsLogger.log(e, st);
      rethrow;
    }
  }

  //
}
