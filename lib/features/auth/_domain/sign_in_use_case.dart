

import '../_data/auth_repo_provider.dart';

final class SignInUseCase {
  final IAuthRepo authRepo;
  const SignInUseCase(this.authRepo);

  Future<void> call({required String email, required String password}) {
    return authRepo.signIn(email: email, password: password);
  }
}
