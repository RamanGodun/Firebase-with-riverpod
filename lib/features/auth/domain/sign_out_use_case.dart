import '../data/sign_out_repo.dart';

final class SignOutUseCase {
  final ISignOutRepo repo;
  const SignOutUseCase(this.repo);

  Future<void> call() => repo.signOut();
}
