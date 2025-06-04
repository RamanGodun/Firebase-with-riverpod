import '../../../core/shared_layers/shared_domain/entities/app_user.dart';

/// 🧼 Contract-level abstraction for the repository.
// ───────────────────────────────────────────────
abstract interface class IProfileRepo {
  Future<AppUser> getProfile({required String userID});
  void clearCache();
}
