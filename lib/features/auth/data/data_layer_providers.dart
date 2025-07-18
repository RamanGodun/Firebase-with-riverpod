import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/i_repo.dart';
import 'remote_database_impl.dart';
import 'i_remote_database.dart';
import 'auth_repo_implementations/sign_in_repo_impl.dart';
import 'auth_repo_implementations/sign_out_repo_impl.dart';
import 'auth_repo_implementations/sign_up_repo_impl.dart';

part 'data_layer_providers.g.dart';

/// 🔌 [authRemoteDataSourceProvider] — provides instance of [AuthRemoteDataSourceImpl]
/// 🧼 Dependency injection for Firebase Auth access
//
@riverpod
IAuthRemoteDataSource authRemoteDataSource(Ref ref) =>
    AuthRemoteDataSourceImpl();

////

////

/// 🧩 [signInRepoProvider] — provides instance of [SignInRepoImpl], injects [IAuthRemoteDataSource] from [authRemoteDataSourceProvider]
//
@Riverpod(keepAlive: false)
ISignInRepo signInRepo(Ref ref) {
  final remote = ref.watch(authRemoteDataSourceProvider);
  return SignInRepoImpl(remote);
}

////

////

/// 🧩 [signOutRepoProvider] — provides instance of [SignOutRepoImpl], injects [IAuthRemoteDataSource]
//
@riverpod
ISignOutRepo signOutRepo(Ref ref) {
  final remote = ref.watch(authRemoteDataSourceProvider);
  return SignOutRepoImpl(remote);
}

////

////

/// 🧩 [signUpRepoProvider] — provides instance of [SignUpRepoImpl], injects [IAuthRemoteDataSource]
//
@riverpod
ISignUpRepo signUpRepo(Ref ref) {
  final remote = ref.watch(authRemoteDataSourceProvider);
  return SignUpRepoImpl(remote);
}
