import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import '../../../app_bootstrap_and_config/app_config/firebase/firebase_constants.dart';

/// 📡 [IProfileRemoteDataSource] — contract for profile document loading
/// 🧼 Abstracts data fetching from Firestore for user profile

abstract interface class IProfileRemoteDataSource {
  ///---------------------------------------------
  //
  /// 🔽 Fetches user document from Firestore by [uid]
  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserDoc(String uid);
  //
}

////

////

/// 🛠️ [ProfileRemoteDataSourceImpl] — Firestore-based implementation
/// 🧱 Provides actual data access logic behind the [IProfileRemoteDataSource]

final class ProfileRemoteDataSourceImpl implements IProfileRemoteDataSource {
  // ────────────────────────────────────────────────────────────────────────
  //
  /// 📥 Loads Firestore document for the given user ID
  /// ⚠️ If document doesn't exist — logic is handled at repository level
  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserDoc(String uid) {
    return usersCollection.doc(uid).get();
  }

  //
}
