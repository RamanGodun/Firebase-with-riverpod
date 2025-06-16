import 'package:firebase_with_riverpod/features/profile/domain/entities/app_user_mapper.dart';

import '../../../core/app_configs/firebase/firebase_constants.dart';
import '../domain/entities/app_user_entity.dart';
import '../../../core/shared_modules/errors_handling/either/either.dart';
import '../../../core/shared_modules/errors_handling/failures/failure_entity.dart';
import '../../../core/shared_modules/errors_handling/utils/exceptions_to_failures_mapper/_exceptions_to_failures_mapper.dart';
import '../../../core/general_utils/typedef.dart';
import '../domain/profile_repo_contract.dart';
import 'data_transfer_objects/app_user_dto.dart';
import 'remote_data_source.dart';

/// [ProfileRepoImpl] - concrete repository, that handles logic via data source.

final class ProfileRepoImpl implements IProfileRepo {
  final IProfileRemoteDataSource _remote;
  ProfileRepoImpl(this._remote);
  // ─────────────────────────

  AppUser? _cachedUser;
  DateTime? _lastFetched;

  static const Duration _cacheDuration = Duration(minutes: 5);

  ///
  @override
  ResultFuture<AppUser> getProfile({required String userID}) async {
    //
    try {
      final now = DateTime.now();

      // Caching (up to 5 min)
      if (_cachedUser != null && _lastFetched != null) {
        final isValid = now.difference(_lastFetched!) < _cacheDuration;
        if (isValid) return Right(_cachedUser!);
      }

      // Doc loading from Firestore
      final doc = await _remote.fetchUserDoc(userID);

      // ⛔ If user doc missing — create it using FirebaseAuth
      if (!doc.exists) {
        final firebaseUser = fbAuth.currentUser;

        // ⛔ FirebaseAuth  not initialized
        if (firebaseUser == null) {
          throw FirebaseUserMissingFailure();
        }

        final newUser = AppUser(
          id: firebaseUser.uid,
          name:
              firebaseUser.displayName?.trim().isNotEmpty == true
                  ? firebaseUser.displayName!
                  : 'User',
          email: firebaseUser.email ?? 'unknown',
        );

        // 💾 Save user to Firestore via DTO
        final dto = newUser.toDto();
        await usersCollection.doc(userID).set(dto.toJson());

        _cachedUser = newUser;
        _lastFetched = now;
        return Right(newUser);
      }

      // ✅ Parse existing Firestore document into DTO, then domain entity
      final user = AppUserDto.fromDoc(doc).toDomain();

      _cachedUser = user;
      _lastFetched = now;

      return Right(user);
    } catch (e, s) {
      return Left(ExceptionToFailureMapper.from(e, s));
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
