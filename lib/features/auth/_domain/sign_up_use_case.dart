

import '../_data/auth_repo_provider.dart';

final class SignUpUseCase {
  final IAuthRepo repo;
  const SignUpUseCase(this.repo);

  Future<void> call({
    required String name,
    required String email,
    required String password,
  }) {
    return repo.signup(name: name, email: email, password: password);
  }
}
