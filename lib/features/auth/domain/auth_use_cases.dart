import 'auth_repos.dart';

///

/// 📦 [EmailVerificationUseCase] — handles email verification workflow
/// 🧼 Sends verification email and checks status after reload
//------------------------------------------------------------------
final class EmailVerificationUseCase {
  //
  final IEmailVerificationRepo repo;
  const EmailVerificationUseCase(this.repo);

  // 📧 Sends verification email to the user
  Future<void> sendVerificationEmail() => repo.sendEmailVerification();
  // ✅ Reloads user and checks if email is verified
  Future<bool> checkIfEmailVerified() async {
    await repo.reloadUser();
    return repo.isEmailVerified();
  }
}
