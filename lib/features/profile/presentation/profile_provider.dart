import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/shared_layers/shared_domain/entities/app_user.dart';
import '../domain_and_data/_profile_use_case.dart';
import '../domain_and_data/profile_repo_provider.dart';

part 'profile_provider.g.dart';

/// 🧩 [profileProvider] — state manager, that delegates logic to use case.
//----------------------------------------------------------------//
@riverpod
Future<AppUser> profile(Ref ref, String uid) {
  final repo = ref.watch(profileRepoProvider);
  final useCase = GetProfileUseCase(repo);
  return useCase.call(uid);
}
