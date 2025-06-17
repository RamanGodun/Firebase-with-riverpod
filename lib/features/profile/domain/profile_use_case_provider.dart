import 'package:firebase_with_riverpod/features/profile/domain/entities/_user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/utils_shared/typedef.dart';
import '../data/profile_repo_provider.dart';
import 'profile_repo_contract.dart';

part 'profile_use_case_provider.g.dart';

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

/// 🧩 [getProfileUseCaseProvider] encapsulated business logic

final class GetProfileUseCase {
  //----------------------------

  final IProfileRepo repo;
  const GetProfileUseCase(this.repo);

  ResultFuture<UserEntity> call(String uid) {
    return repo.getProfile(userID: uid);
  }

  //
}
