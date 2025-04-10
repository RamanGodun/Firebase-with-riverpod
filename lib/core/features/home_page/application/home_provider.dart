import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../domain/entities/app_user.dart';
import '../../../data/repositories/profile/profile_repository_provider.dart';

part 'home_provider.g.dart';

/// **Profile Provider**
///
/// - Fetches the user profile from `ProfileRepository`.
/// - Uses `FutureOr<AppUser>` to handle both synchronous and asynchronous cases.
/// - Watches the `profileRepositoryProvider` for dependency injection.
///
/// **Parameters:**
/// - `uid` (String): The unique identifier of the user.
///
/// **Returns:**
/// - A `FutureOr<AppUser>` containing the user's profile data.
@riverpod
FutureOr<AppUser> profile(Ref ref, String uid) {
  return ref.watch(profileRepositoryProvider).getProfile(uid: uid);
}
