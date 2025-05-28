import 'package:flutter_riverpod/flutter_riverpod.dart' show Ref;
import 'package:riverpod_annotation/riverpod_annotation.dart' show riverpod;

import '../../../core/config/firebase/firebase_constants.dart';

part 'auth_repo_provider.g.dart';

@riverpod
IAuthRepo authRepo(Ref ref) => AuthRepoImpl();

abstract interface class IAuthRepo {
  //
  Future<void> signIn({required String email, required String password});

  ///
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  });

  // ...
}

///
final class AuthRepoImpl implements IAuthRepo {
  @override
  Future<void> signIn({required String email, required String password}) async {
    await fbAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final userCredential = await fbAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user!;
    await usersCollection.doc(user.uid).set({'name': name, 'email': email});
  }

  ///
}
