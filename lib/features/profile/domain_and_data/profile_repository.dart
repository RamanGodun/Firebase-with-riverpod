import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/shared_domain/entities/app_user.dart';
import 'remote_data_source.dart';

/// DI binding for repository + data source.
// ─────────────────────────────────────────────────────────────
final profileRepositoryProvider = Provider<IProfileRepo>((ref) {
  return ProfileRepoImpl(ProfileRemoteDataSourceImpl());
});

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

    // 🧠 Перевірка: якщо кеш є і він ще дійсний — повертаємо його
    if (_cachedUser != null && _lastFetched != null) {
      final isValid = now.difference(_lastFetched!) < _cacheDuration;
      if (isValid) {
        return _cachedUser!;
      }
    }

    // 📥 Інакше — робимо запит до Firestore
    final doc = await _remote.fetchUserDoc(userID);
    final user = AppUser.fromDoc(doc);

    // 🧊 Зберігаємо в кеш
    _cachedUser = user;
    _lastFetched = now;

    return user;
  }

  /// 🧹 Очистка кешу вручну
  @override
  void clearCache() {
    _cachedUser = null;
    _lastFetched = null;
  }
}
