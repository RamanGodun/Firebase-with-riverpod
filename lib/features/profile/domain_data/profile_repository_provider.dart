import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '_profile_repository.dart';

part 'profile_repository_provider.g.dart';

/// 🧩 [profileRepositoryProvider] — provides instance of [ProfileRepository]
/// 🧼 Used to handle user profile-related data access (DI)
//----------------------------------------------------------------//

@riverpod
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepository();
}
