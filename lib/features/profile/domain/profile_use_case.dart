import '../../../core/utils_shared/type_definitions.dart';
import 'entities/_user_entity.dart';
import 'profile_repo_contract.dart';

/// 🧩 [getProfileUseCaseProvider] encapsulated business logic
//
final class GetProfileUseCase {
  ///-------------------------
  //
  final IProfileRepo repo;
  const GetProfileUseCase(this.repo);
  //
  ResultFuture<UserEntity> call(String uid) {
    return repo.getProfile(userID: uid);
  }
}
