import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/entities/app_user.dart';
import '../../../data/repositories/profile/profile_repository_provider.dart';

part 'profile_provider.g.dart';

@riverpod
FutureOr<AppUser> profile(Ref ref, String uid) {
  return ref.watch(profileRepositoryProvider).getProfile(userID: uid);
}
