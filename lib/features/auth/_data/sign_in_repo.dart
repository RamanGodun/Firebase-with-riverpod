import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/config/firebase/firebase_constants.dart';

part 'sign_in_repo.g.dart';

/// 🔐 Sign in repo provider
@riverpod
ISignInRepo signInRepo(Ref ref) => SignInRepoImpl();

/// 🔐 Sign in contract
abstract interface class ISignInRepo {
  Future<void> signIn({required String email, required String password});
}

/// 🔐 Signs user in using email and password
final class SignInRepoImpl implements ISignInRepo {
  @override
  Future<void> signIn({required String email, required String password}) async {
    await fbAuth.signInWithEmailAndPassword(email: email, password: password);
  }
}
