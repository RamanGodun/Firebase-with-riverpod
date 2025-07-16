import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/auth_repo_contracts.dart';
import 'auth_repo_implementations.dart';

part 'auth_repo_providers.g.dart';

/// 🧩 [signInRepoProvider] — provides instance of [SignInRepoImpl]
/// 🧼 Dependency injection for user sign-in logic

@Riverpod(keepAlive: false)
ISignInRepo signInRepo(Ref ref) => SignInRepoImpl();

////

////

/// 🧩 [signOutRepoProvider] — provides instance of [SignOutRepoImpl]
/// 🧼 Dependency injection for sign-out operation

@riverpod
ISignOutRepo signOutRepo(Ref ref) => SignOutRepoImpl();

////

////

/// 🧩 [signUpRepoProvider] — provides instance of [SignUpRepoImpl]
/// 🧼 Dependency injection for sign-up logic

@riverpod
ISignUpRepo signUpRepo(Ref ref) => SignUpRepoImpl();
