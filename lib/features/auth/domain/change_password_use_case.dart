import '../data/change_password_repo.dart';

/// 📦 [ChangePasswordUseCase] — encapsulates password change logic
//------------------------------------------------------------------

final class ChangePasswordUseCase {
  final IChangePasswordRepo repo;
  const ChangePasswordUseCase(this.repo);

  Future<void> call(String password) {
    return repo.changePassword(password);
  }
}
