import '../../../core/shared_domain_layer/shared_entities/_user_entity.dart';
import '../../../core/utils_shared/type_definitions.dart';

/// 📦 [IProfileRepo] — Contract for [FetchProfileUseCase] repo
//
abstract interface class IProfileRepo {
  ///-------------------------------
  //
  ///
  ResultFuture<UserEntity> getProfile({required String uid});
  //
  /// ✅ Create the user profile if not exists in the database (e.g. Firestore)
  ResultFuture<void> createUserProfile(String uid);
  //
  /// Clears in-memory cache (optional, use empty implementation if not needed).
  void clearCache();
  //
}
