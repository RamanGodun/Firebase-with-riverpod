import '../data/change_password_repo.dart';

/// 📦 [ChangePasswordUseCase] — encapsulates password change logic
//------------------------------------------------------------------

final class ChangePasswordUseCase {
  final IChangePasswordRepo repo;
  const ChangePasswordUseCase(this.repo);

  /// 🔁 Triggers password changing
  Future<void> call(String newPassword) {
    return repo.changePassword(newPassword);
  }
}
