import '../../../core/shared_layers/shared_domain/entities/app_user.dart';
import '../../../core/general_utils/typedef.dart';

/// 🧼 Contract-level abstraction for the repository.
// ───────────────────────────────────────────────
abstract interface class IProfileRepo {
  ResultFuture<AppUser> getProfile({required String userID});
  void clearCache();
}
