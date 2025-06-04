import '../../../core/shared_layers/shared_domain/entities/app_user.dart';
import '../../../core/utils/typedef.dart';
import 'profile_repo.dart';

/// 🧩 [getProfileUseCaseProvider] encapsulated business logic
// ─────────────────────────────────────────────────────────────
final class GetProfileUseCase {
  //
  final IProfileRepo repo;
  const GetProfileUseCase(this.repo);

  ResultFuture<AppUser> call(String uid) {
    return repo.getProfile(userID: uid);
  }
}
