import 'package:firebase_with_riverpod/core/base_modules/errors_handling/utils/failure_handling.dart';
import 'package:firebase_with_riverpod/features/profile/data/data_transfer_objects/user_dto_x.dart';
import '../../../core/utils_shared/type_definitions.dart';
import '../domain/entities/_user_entity.dart';
import '../domain/i_repo.dart';
import 'i_remote_databse.dart';

/// 🧩 [ProfileRepoImpl] — implements [IProfileRepo] with error mapping and caching
/// 🧼 Converts DTO ➡️ Entity, adds 5 min in-memory caching, handles failures
//
final class ProfileRepoImpl implements IProfileRepo {
  // ─────────────────────────----------------------
  final IProfileRemoteDataSource _remote;
  ProfileRepoImpl(this._remote);
  //

  UserEntity? _cachedUser;
  DateTime? _lastFetched;
  static const Duration _cacheDuration = Duration(minutes: 5);

  /// 🧠 Returns cached user if fresh, otherwise fetches from remote and caches result
  @override
  ResultFuture<UserEntity> getProfile({required String userID}) =>
      (() async {
        final now = DateTime.now();

        // 🧺 Return cache if still valid
        if (_cachedUser != null && _lastFetched != null) {
          final isValid = now.difference(_lastFetched!) < _cacheDuration;
          if (isValid) return _cachedUser!;
        }

        // 🛜 Fetch from remote and convert
        final dto = await _remote.fetchOrCreateUser(userID);
        final user = dto.toEntity();
        _cachedUser = user;
        _lastFetched = now;
        return user;
        //
      }).runWithErrorHandling();

  /// ♻️ Clears in-memory cache
  @override
  void clearCache() {
    _cachedUser = null;
    _lastFetched = null;
  }

  //
}
