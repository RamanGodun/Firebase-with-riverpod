import 'package:firebase_with_riverpod/features/profile/data/data_transfer_objects/user_dto_x.dart';

import '../../../core/app_configs/firebase/firebase_constants.dart';
import '../../../core/utils_shared/typedef.dart';
import '../../../core/modules_shared/errors_handling/either/either.dart';
import '../../../core/modules_shared/errors_handling/failures/failure_entity.dart';
import '../../../core/modules_shared/errors_handling/utils/exceptions_to_failures_mapper/_exceptions_to_failures_mapper.dart';
import '../domain/entities/_user_entity.dart';
import '../domain/profile_repo_contract.dart';
import 'data_transfer_objects/user_dto_factories_x.dart';
import 'remote_data_source.dart';

/// [ProfileRepoImpl] - concrete repository, that handles logic via data source.

final class ProfileRepoImpl implements IProfileRepo {
  // ─────────────────────────----------------------

  final IProfileRemoteDataSource _remote;
  ProfileRepoImpl(this._remote);
  //

  UserEntity? _cachedUser;
  DateTime? _lastFetched;
  static const Duration _cacheDuration = Duration(minutes: 5);

  ///
  @override
  ResultFuture<UserEntity> getProfile({required String userID}) async {
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

        final dto = UserDTOFactories.newUser(
          id: firebaseUser.uid,
          name:
              firebaseUser.displayName?.trim().isNotEmpty == true
                  ? firebaseUser.displayName!
                  : 'User',
          email: firebaseUser.email ?? 'unknown',
        );

        // 💾 Save user to Firestore via DTO
        await usersCollection.doc(userID).set(dto.toJsonMap());

        final newUser = dto.toEntity();
        _cachedUser = newUser;
        _lastFetched = now;
        return Right(newUser);
      }

      // ✅ Parse existing Firestore document into DTO, then domain entity
      final UserEntity user = UserDTOFactories.fromDoc(doc).toEntity();

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
