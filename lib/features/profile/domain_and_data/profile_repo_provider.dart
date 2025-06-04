import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/shared_layers/shared_domain/entities/app_user.dart';
import '../../../core/shared_modules/errors_handling/either_for_data/either.dart';
import '../../../core/shared_modules/errors_handling/utils/failure_mapper.dart';
import '../../../core/utils/typedef.dart';
import 'profile_repo.dart';
import 'remote_data_source.dart';

part 'profile_repo_provider.g.dart';

/// DI binding for repository + data source.
// ─────────────────────────────────────────────────────────────
@riverpod
IProfileRepo profileRepo(Ref ref) {
  return ProfileRepoImpl(ProfileRemoteDataSourceImpl());
}

/// [ProfileRepoImpl] - concrete repository, that handles logic via data source.
// ─────────────────────────────────────────────────────────────
final class ProfileRepoImpl implements IProfileRepo {
  final IProfileRemoteDataSource _remote;
  ProfileRepoImpl(this._remote);

  AppUser? _cachedUser;
  DateTime? _lastFetched;

  static const Duration _cacheDuration = Duration(minutes: 5);

  ///
  @override
  ResultFuture<AppUser> getProfile({required String userID}) async {
    try {
      final now = DateTime.now();

      if (_cachedUser != null && _lastFetched != null) {
        final isValid = now.difference(_lastFetched!) < _cacheDuration;
        if (isValid) return Right(_cachedUser!);
      }

      final doc = await _remote.fetchUserDoc(userID);
      final user = AppUser.fromDoc(doc);
      _cachedUser = user;
      _lastFetched = now;

      return Right(user);
    } catch (e, s) {
      return Left(FailureMapper.from(e, s));
    }
  }

  ///
  @override
  void clearCache() {
    _cachedUser = null;
    _lastFetched = null;
  }

  //
}
