import 'package:firebase_with_riverpod/features/auth/domain/auth_repos.dart'
    show ISignUpRepo;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/shared_modules/errors_handling/utils/for_riverpod/helpers.dart';
import '../../../core/utils/typedef.dart';
import '../data_providers/sign_up_repo_provider.dart';

part 'sign_up_use_case_provider.g.dart';

/// 🧩 Provides [SignUpUseCase] via injected repo
@riverpod
SignUpUseCase signUpUseCase(Ref ref) {
  final repo = ref.watch(signUpRepoProvider);
  return SignUpUseCase(repo);
}

///

/// 📦 [SignUpUseCase] — encapsulates user registration
/// 🧼 Creates Firebase user and stores user profile via [ISignUpRepo]
//------------------------------------------------------------------
final class SignUpUseCase {
  //
  final ISignUpRepo repo;
  const SignUpUseCase(this.repo);

  // 🔐 Регіструє нового користувача та повертає результат
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
