import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import '../../../core/config/bootstrap/firebase/firebase_constants.dart';

abstract interface class IProfileRemoteDataSource {
  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserDoc(String uid);
}

/// Concrete Firestore access.
// ─────────────────────────────────────────────────────────────
final class ProfileRemoteDataSourceImpl implements IProfileRemoteDataSource {
  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserDoc(String uid) {
    return usersCollection.doc(uid).get();
  }
}
