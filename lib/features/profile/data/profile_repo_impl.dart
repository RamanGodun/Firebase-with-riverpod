import '../../../core/app_configs/firebase/firebase_constants.dart';
import '../../../core/shared_layers/shared_domain/entities/app_user.dart';
import '../../../core/shared_modules/errors_handling/either_for_data/either.dart';
import '../../../core/shared_modules/errors_handling/failures_for_domain_and_presentation/failure_for_domain.dart';
import '../../../core/shared_modules/errors_handling/utils/failure_mapper.dart';
import '../../../core/utils/typedef.dart';
import '../domain_and_data/profile_repo.dart';
import 'remote_data_source.dart';

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

        // Write user data in Firestore
        await usersCollection.doc(userID).set(newUser.toJson());

        _cachedUser = newUser;
        _lastFetched = now;
        return Right(newUser);
      }

      // ✅ If doc exists, then parse it through model
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
