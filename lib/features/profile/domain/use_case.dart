import '../../../core/utils_shared/type_definitions.dart';
import 'entities/_user_entity.dart';
import 'i_repo.dart';

/// 📦 [GetProfileUseCase] — encapsulates domain logic to fetch user profile
/// 🧼 Delegates call to repository abstraction
//
final class GetProfileUseCase {
  ///-------------------------
  //
  final IProfileRepo repo;
  const GetProfileUseCase(this.repo);
  //
  /// 🔁 Calls the repository and returns result
  ResultFuture<UserEntity> call(String uid) {
    return repo.getProfile(userID: uid);
  }
}
