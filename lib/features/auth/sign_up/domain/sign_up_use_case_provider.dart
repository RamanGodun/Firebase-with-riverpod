import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/general_utils/typedef.dart';
import '../../../../core/shared_modules/errors_handling/utils/for_riverpod/failure_utils.dart';
import '../data/sign_up_repo_provider.dart';
import 'sign_up_repo_contract.dart';

part 'sign_up_use_case_provider.g.dart';

/// 🧩 Provides [SignUpUseCase] via injected repo

@riverpod
SignUpUseCase signUpUseCase(Ref ref) {
  final repo = ref.watch(signUpRepoProvider);
  return SignUpUseCase(repo);
}

////

////

/// 📦 [SignUpUseCase] — encapsulates user registration
/// 🧼 Creates Firebase user and stores user profile via [ISignUpRepo]

final class SignUpUseCase {
  //----------------------

  final ISignUpRepo repo;
  const SignUpUseCase(this.repo);

  // 🔐 Register a new user and returns result
  ResultFuture<void> call({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await repo.signup(name: name, email: email, password: password);
      return right(null);
    } catch (e, st) {
      return left(mapToFailure(e, st));
    }
  }

  //
}
