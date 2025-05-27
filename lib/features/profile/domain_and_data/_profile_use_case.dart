import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/shared_domain/entities/app_user.dart';
import 'profile_repository.dart';

/// 🧩 [getProfileUseCaseProvider] encapsulated business logic
// ─────────────────────────────────────────────────────────────
final getProfileUseCaseProvider = Provider.family<GetProfileUseCase, String>((
  ref,
  uid,
) {
  final repo = ref.watch(profileRepositoryProvider);
  return GetProfileUseCase(repo);
});

final class GetProfileUseCase {
  final IProfileRepo profileRepo;
  const GetProfileUseCase(this.profileRepo);

  Future<AppUser> call(String userID) {
    return profileRepo.getProfile(userID: userID);
  }
}
