import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/utils_shared/type_definitions.dart';
import '../data/profile_repo_provider.dart';
import 'entities/_user_entity.dart';
import 'profile_repo_contract.dart';

part 'profile_use_case_provider.g.dart';

/// 🧩 [getProfileUseCaseProvider] — provides [GetProfileUseCase]
/// 🧼 Injects repository dependency from data layer
//
@Riverpod(keepAlive: false)
GetProfileUseCase getProfileUseCase(Ref ref) {
  ///-----------------------------------------
  //
  final repo = ref.watch(profileRepoProvider);
  return GetProfileUseCase(repo);
  //
}

////

////

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
