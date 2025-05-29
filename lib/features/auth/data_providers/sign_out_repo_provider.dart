import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/app_config/firebase/firebase_constants.dart';
import '../domain/auth_repos.dart';

part 'sign_out_repo_provider.g.dart';

/// 🧩 [signOutRepoProvider] — provides instance of [SignOutRepoImpl]
/// 🧼 Dependency injection for sign-out operation
@riverpod
ISignOutRepo signOutRepo(Ref ref) => SignOutRepoImpl();

///-----------------------------------------------------------------
/// 🧩 [SignOutRepoImpl] — concrete implementation of [ISignOutRepo]
/// 🧼 Wraps [FirebaseAuth.signOut]
final class SignOutRepoImpl implements ISignOutRepo {
  @override
  Future<void> signOut() async {
    await fbAuth.signOut();
  }
}
