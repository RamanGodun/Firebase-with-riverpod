import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/app_configs/firebase/firebase_constants.dart';
import '../../../../core/shared_modules/errors_handling/utils/observers/loggers/errors_log_util.dart';
import '../domain/sign_up_repo_contract.dart';

part 'sign_up_repo_provider.g.dart';

/// 🧩 [signUpRepoProvider] — provides instance of [SignUpRepoImpl]
/// 🧼 Dependency injection for sign-up logic

@riverpod
ISignUpRepo signUpRepo(Ref ref) => SignUpRepoImpl();

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
      await usersCollection.doc(user.uid).set({'name': name, 'email': email});
    } on FirebaseAuthException catch (e, st) {
      ErrorsLogger.log(e, st);
      rethrow;
    }
  }

  //
}
