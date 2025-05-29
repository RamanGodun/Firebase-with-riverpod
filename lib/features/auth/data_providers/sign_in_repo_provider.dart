import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/app_config/firebase/firebase_constants.dart';
import '../domain/auth_repos.dart';

part 'sign_in_repo_provider.g.dart';

/// 🧩 [signInRepoProvider] — provides instance of [SignInRepoImpl]
/// 🧼 Dependency injection for user sign-in logic
@riverpod
ISignInRepo signInRepo(Ref ref) => SignInRepoImpl();

///----------------------------------------------------------------
/// 🧩 [SignInRepoImpl] — concrete implementation of [ISignInRepo]
/// 🧼 Wraps [FirebaseAuth.signInWithEmailAndPassword]
final class SignInRepoImpl implements ISignInRepo {
  @override
  Future<void> signIn({required String email, required String password}) async {
    await fbAuth.signInWithEmailAndPassword(email: email, password: password);
  }
}
