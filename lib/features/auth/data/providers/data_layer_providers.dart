import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/repo_contracts.dart';
import '../auth_repo_implementations/sign_in_repo_impl.dart';
import '../auth_repo_implementations/sign_out_repo_impl.dart';
import '../auth_repo_implementations/sign_up_repo_impl.dart';
import '../remote_database_contract.dart';
import '../remote_database_impl.dart';

part 'data_layer_providers.g.dart';

/// 🔌 [authRemoteDataSourceProvider] — provides instance of [AuthRemoteDatabaseImpl]
/// 🧼 Dependency injection for Firebase Auth access
//
@riverpod
IAuthRemoteDatabase authRemoteDatabase(Ref ref) => AuthRemoteDatabaseImpl();

////

////

/// 🧩 [signInRepoProvider] — provides instance of [SignInRepoImpl], injects [IAuthRemoteDatabase] from [authRemoteDataSourceProvider]
//
@Riverpod(keepAlive: false)
ISignInRepo signInRepo(Ref ref) {
  final remote = ref.watch(authRemoteDatabaseProvider);
  return SignInRepoImpl(remote);
}

////

////

/// 🧩 [signOutRepoProvider] — provides instance of [SignOutRepoImpl], injects [IAuthRemoteDatabase]
//
@riverpod
ISignOutRepo signOutRepo(Ref ref) {
  final remote = ref.watch(authRemoteDatabaseProvider);
  return SignOutRepoImpl(remote);
}

////

////

/// 🧩 [signUpRepoProvider] — provides instance of [SignUpRepoImpl], injects [IAuthRemoteDatabase]
//
@riverpod
ISignUpRepo signUpRepo(Ref ref) {
  final remote = ref.watch(authRemoteDatabaseProvider);
  return SignUpRepoImpl(remote);
}
