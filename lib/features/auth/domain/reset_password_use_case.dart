import '../data/reset_password_repo.dart';

final class ResetPasswordUseCase {
  final IResetPasswordRepo repo;
  const ResetPasswordUseCase(this.repo);

  Future<void> call(String email) => repo.sendResetLink(email);
}
