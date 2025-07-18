import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/data_layer_providers.dart';
import 'use_cases/sign_in.dart';
import 'use_cases/sign_out.dart';
import 'use_cases/sign_up.dart';

part 'use_cases_providers.g.dart';

/// 🧩 [signInUseCaseProvider] — provides instance of [SignInUseCase]
/// 🧼 Depends on [signInRepoProvider] to inject repository
//
@Riverpod(keepAlive: false)
SignInUseCase signInUseCase(Ref ref) {
  final repo = ref.watch(signInRepoProvider);
  return SignInUseCase(repo);
}

////

////
/// 🧩 Provides [SignOutUseCase] via injected repo
//
@Riverpod(keepAlive: false)
SignOutUseCase signOutUseCase(Ref ref) {
  final repo = ref.watch(signOutRepoProvider);
  return SignOutUseCase(repo);
}

////

////

/// 🧩 Provides [SignUpUseCase] via injected repo
//
@riverpod
SignUpUseCase signUpUseCase(Ref ref) {
  final repo = ref.watch(signUpRepoProvider);
  return SignUpUseCase(repo);
}
