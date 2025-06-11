import 'auth_repos.dart';

/// 📦 [ChangePasswordUseCase] — encapsulates password change logic
/// 🧼 Invokes password update via [IChangePasswordRepo]
//-------------------------------------------------------------
final class ChangePasswordUseCase {
  //
  final IChangePasswordRepo repo;
  const ChangePasswordUseCase(this.repo);

  // 🔁 Triggers password changing
  Future<void> call(String newPassword) {
    return repo.changePassword(newPassword);
  }
}

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

///

/// 📦 [ResetPasswordUseCase] — encapsulates password reset logic
/// 🧼 Triggers password reset email via [IResetPasswordRepo]
//--------------------------------------------------------------
final class ResetPasswordUseCase {
  //
  final IResetPasswordRepo repo;
  const ResetPasswordUseCase(this.repo);

  // 📩 Sends reset link to the provided email
  Future<void> call(String email) => repo.sendResetLink(email);
}

//
