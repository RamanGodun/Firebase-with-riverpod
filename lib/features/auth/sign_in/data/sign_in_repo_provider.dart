import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/app_configs/firebase/firebase_constants.dart';
import '../../../../core/modules_shared/errors_handling/utils/observers/loggers/errors_log_util.dart';
import '../domain/sign_in_repo_contract.dart';

part 'sign_in_repo_provider.g.dart';

/// 🧩 [signInRepoProvider] — provides instance of [SignInRepoImpl]
/// 🧼 Dependency injection for user sign-in logic

@Riverpod(keepAlive: false)
ISignInRepo signInRepo(Ref ref) => SignInRepoImpl();

////

////

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
