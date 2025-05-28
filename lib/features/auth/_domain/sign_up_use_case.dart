import '../_data/sign_up_repo.dart';

final class SignUpUseCase {
  final ISignUpRepo repo;
  const SignUpUseCase(this.repo);

  Future<void> call({
    required String name,
    required String email,
    required String password,
  }) {
    return repo.signup(name: name, email: email, password: password);
  }
}
