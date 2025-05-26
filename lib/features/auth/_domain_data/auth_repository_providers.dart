import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/config/bootstrap/firebase/firebase_constants.dart';
import '_auth_repository.dart';

part 'auth_repository_providers.g.dart';

/// 🧩 [authRepositoryProvider] — provides instance of [AuthRepository]
/// 🧼 Used to perform all authentication logic through DI
//----------------------------------------------------------------//
@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository();
}

/// 🧩 [authStateStreamProvider] — exposes auth state as stream of [User?]
/// 🧼 Reactively notifies when user signs in/out or changes
//----------------------------------------------------------------//
@riverpod
Stream<User?> authStateStream(Ref ref) {
  return fbAuth.authStateChanges();
}
