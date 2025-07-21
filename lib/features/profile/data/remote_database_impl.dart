import 'package:firebase_with_riverpod/features/profile/data/data_transfer_objects/user_dto_x.dart';
import '../../../app_bootstrap_and_config/app_config/firebase/firebase_constants.dart';
import '../../../core/base_modules/errors_handling/failures/failure_model.dart';
import 'data_transfer_objects/_user_dto.dart';
import 'data_transfer_objects/user_dto_factories_x.dart';
import 'i_remote_database.dart';

/// 🛠️ [ProfileRemoteDataSourceImpl] — Firestore implementation of [IProfileRemoteDataSource]
/// 🧱 Loads or creates user documents and prevents duplicate fetches
//
final class ProfileRemoteDataSourceImpl implements IProfileRemoteDataSource {
  ///---------------------------------------------------------------------
  //
  Future<UserDTO>? _inFlightFetch;
  String? _inFlightUid;

  /// 📥 Fetches or creates user document by [uid]
  /// 🛡️ Prevents parallel Firestore reads for same user
  @override
  Future<UserDTO> fetchOrCreateUser(String uid) async {
    // 🛡️ Prevent duplicate simultaneous Firestore reads
    if (_inFlightFetch != null && _inFlightUid == uid) {
      return _inFlightFetch!;
    }

    final future = _fetchOrCreateInternal(uid);
    _inFlightFetch = future;
    _inFlightUid = uid;

    // Clear cache after completion
    return future.whenComplete(() {
      _inFlightFetch = null;
      _inFlightUid = null;
    });
  }

  /// 🧱 Internal Firestore logic: checks doc, creates default if missing
  Future<UserDTO> _fetchOrCreateInternal(String uid) async {
    final doc = await FirebaseConstants.usersCollection.doc(uid).get();

    // ⛔ If user doc missing — create it using FirebaseAuth
    if (!doc.exists) {
      final firebaseUser = FirebaseConstants.fbAuth.currentUser;
      // ⛔ FirebaseAuth  not initialized
      if (firebaseUser == null) throw FirebaseUserMissingFailure();

      final dto = UserDTOFactories.newUser(
        id: firebaseUser.uid,
        name:
            firebaseUser.displayName?.trim().isNotEmpty == true
                ? firebaseUser.displayName!
                : 'User',
        email: firebaseUser.email ?? 'unknown',
      );

      // 💾 Save user to Firestore via DTO
      await FirebaseConstants.usersCollection.doc(uid).set(dto.toJsonMap());
      return dto;
    }

    // ✅ Parse existing Firestore document into DTO, then domain entity
    return UserDTOFactories.fromDoc(doc);
  }

  //
}
