import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/app_config/firebase/firebase_constants.dart';

part 'auth_state_stream_provider.g.dart';

/// 🧩 [authStateStreamProvider] — exposes auth state as stream of [User?]
/// 🧼 Reactively notifies when user signs in/out or changes
//----------------------------------------------------------------//
@riverpod
Stream<User?> authStateStream(Ref ref) {
  return fbAuth.authStateChanges();
}
