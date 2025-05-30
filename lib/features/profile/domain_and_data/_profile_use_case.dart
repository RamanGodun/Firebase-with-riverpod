import '../../../core/shared_layers/shared_domain/entities/app_user.dart';
import 'profile_repo_provider.dart';

/// 🧩 [getProfileUseCaseProvider] encapsulated business logic
// ─────────────────────────────────────────────────────────────

final class GetProfileUseCase {
  final IProfileRepo repo;
  const GetProfileUseCase(this.repo);

  Future<AppUser> call(String uid) {
    return repo.getProfile(userID: uid);
  }
}
