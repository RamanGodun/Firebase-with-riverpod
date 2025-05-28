import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/shared_domain/entities/app_user.dart';
import 'remote_data_source.dart';

part 'profile_repo_provider.g.dart';

/// DI binding for repository + data source.
// ─────────────────────────────────────────────────────────────
@riverpod
IProfileRepo profileRepo(Ref ref) {
  return ProfileRepoImpl(ProfileRemoteDataSourceImpl());
}

/// 🧼 Contract-level abstraction for the repository.
// ───────────────────────────────────────────────
abstract interface class IProfileRepo {
  Future<AppUser> getProfile({required String userID});
  void clearCache();
}

/// [ProfileRepoImpl] - concrete repository, that handles logic via data source.
// ─────────────────────────────────────────────────────────────
final class ProfileRepoImpl implements IProfileRepo {
  final IProfileRemoteDataSource _remote;
  ProfileRepoImpl(this._remote);

  AppUser? _cachedUser;
  DateTime? _lastFetched;

  static const Duration _cacheDuration = Duration(minutes: 5);

  @override
  Future<AppUser> getProfile({required String userID}) async {
    final now = DateTime.now();

    if (_cachedUser != null && _lastFetched != null) {
      final isValid = now.difference(_lastFetched!) < _cacheDuration;
      if (isValid) return _cachedUser!;
    }

    final doc = await _remote.fetchUserDoc(userID);
    final user = AppUser.fromDoc(doc);
    _cachedUser = user;
    _lastFetched = now;

    return user;
  }

  @override
  void clearCache() {
    _cachedUser = null;
    _lastFetched = null;
  }

  //
}
