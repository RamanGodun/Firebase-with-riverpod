import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '_profile_repository.dart';

part 'profile_repository_provider.g.dart';

/// **Profile Repository Provider**
///
/// A Riverpod provider that exposes an instance of [ProfileRepository].
///
/// - **Usage:** Provides access to user profile operations such as fetching user details.
/// - **Scope:** Singleton instance managed by Riverpod.
@riverpod
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepository();
}
