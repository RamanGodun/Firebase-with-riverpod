import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/utils_shared/typedef.dart';
import '../../../../core/modules_shared/errors_handling/utils/for_riverpod/failure_utils.dart';
import '../data/sign_in_repo_provider.dart';
import 'sign_in_repo_contract.dart';

part 'sign_in_use_case_provider.g.dart';

/// 🧩 [signInUseCaseProvider] — provides instance of [SignInUseCase]
/// 🧼 Depends on [signInRepoProvider] to inject repository

@Riverpod(keepAlive: false)
SignInUseCase signInUseCase(Ref ref) {
  final repo = ref.watch(signInRepoProvider);
  return SignInUseCase(repo);
}

///

///

/// 📦 [SignInUseCase] — encapsulates sign-in process
/// 🧼 Handles user authentication using [ISignInRepo]

final class SignInUseCase {
  //----------------------

  final ISignInRepo authRepo;
  const SignInUseCase(this.authRepo);

  // 🔐 Signs in with provided credentials
  ResultFuture<void> call({
    required String email,
    required String password,
  }) async {
    try {
      await authRepo.signIn(email: email, password: password);
      return right(null);
    } catch (e, st) {
      return left(mapToFailure(e, st));
    }
  }

  //
}
