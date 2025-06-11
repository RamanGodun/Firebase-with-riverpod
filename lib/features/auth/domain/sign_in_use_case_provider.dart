import 'package:firebase_with_riverpod/features/auth/domain/auth_repos.dart'
    show ISignInRepo;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/shared_modules/errors_handling/utils/helpers.dart';
import '../../../core/utils/typedef.dart';
import '../data_providers/sign_in_repo_provider.dart';

part 'sign_in_use_case_provider.g.dart';

/// 🧩 [signInUseCaseProvider] — provides instance of [SignInUseCase]
/// 🧼 Depends on [signInRepoProvider] to inject repository
@Riverpod(keepAlive: false)
SignInUseCase signInUseCase(Ref ref) {
  final repo = ref.watch(signInRepoProvider);
  return SignInUseCase(repo);
}

///

/// 📦 [SignInUseCase] — encapsulates sign-in process
/// 🧼 Handles user authentication using [ISignInRepo]
//------------------------------------------------------------
final class SignInUseCase {
  //
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
