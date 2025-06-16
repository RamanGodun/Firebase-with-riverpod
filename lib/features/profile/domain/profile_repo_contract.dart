import 'entities/app_user_entity.dart';
import '../../../core/general_utils/typedef.dart';

/// 🧼 Contract-level abstraction for the repository.

abstract interface class IProfileRepo {
  // ─────────────────────────────────

  ResultFuture<AppUser> getProfile({required String userID});
  void clearCache();
}
