import '../data/email_verification_repo.dart';

final class EmailVerificationUseCase {
  final IEmailVerificationRepo repo;
  const EmailVerificationUseCase(this.repo);

  Future<void> sendVerificationEmail() => repo.sendEmailVerification();

  Future<bool> checkIfEmailVerified() async {
    await repo.reloadUser();
    return repo.isEmailVerified();
  }
}
