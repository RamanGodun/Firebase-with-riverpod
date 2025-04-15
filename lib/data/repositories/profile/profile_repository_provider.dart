import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '_profile_repository.dart';

part 'profile_repository_provider.g.dart';

///[profileRepository] exposes an instance of [ProfileRepository]. Singleton instance managed by Riverpod
@riverpod
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepository();
}
