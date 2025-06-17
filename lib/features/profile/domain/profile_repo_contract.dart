import '../../../core/utils_shared/typedef.dart';
import 'entities/_user_entity.dart';

/// 🧼 Contract-level abstraction for the repository.

abstract interface class IProfileRepo {
  // ─────────────────────────────────

  ResultFuture<UserEntity> getProfile({required String userID});
  void clearCache();
}
