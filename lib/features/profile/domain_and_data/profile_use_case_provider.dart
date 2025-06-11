import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/shared_layers/shared_domain/entities/app_user.dart';
import '../../../core/utils/typedef.dart';
import '../data/profile_repo_provider.dart';
import 'profile_repo.dart';

part 'profile_use_case_provider.g.dart';

@Riverpod(keepAlive: false)
GetProfileUseCase getProfileUseCase(Ref ref) {
  final repo = ref.watch(profileRepoProvider);
  return GetProfileUseCase(repo);
}

///

/// 🧩 [getProfileUseCaseProvider] encapsulated business logic
final class GetProfileUseCase {
  final IProfileRepo repo;
  const GetProfileUseCase(this.repo);

  ResultFuture<AppUser> call(String uid) {
    return repo.getProfile(userID: uid);
  }
}
