import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'auth_repository.dart';
import 'sources/remote/consts/firebase_constants.dart';

part 'auth_repository_provider.g.dart';

/// **Authentication Repository Provider**
///
/// Provides an instance of [AuthRepository] to manage authentication-related operations.
@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository();
}

/// **Authentication State Stream Provider**
///
/// Listens to the authentication state changes and provides a [Stream] of [User?].
/// This allows the app to react to sign-in, sign-out, and user state changes.
@riverpod
Stream<User?> authStateStream(Ref ref) {
  return fbAuth.authStateChanges();
}
