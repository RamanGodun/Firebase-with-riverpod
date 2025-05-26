import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/shared_domain/entities/app_user.dart';
import '../../../core/config/bootstrap/firebase/firebase_constants.dart';

/// 🧩 [ProfileRepository] — abstraction for user profile fetching from Firestore
/// 🧼 Handles retrieving user data by UID
//----------------------------------------------------------------//

final class ProfileRepository {
  // ProfileRepository._();

  /// 🧾 Fetches user profile by [userID] from Firestore
  Future<AppUser> getProfile({required String userID}) async {
    try {
      final DocumentSnapshot doc = await usersCollection.doc(userID).get();

      if (!doc.exists) {
        throw 'User not found';
      }

      return AppUser.fromDoc(doc);
    } catch (e) {
      rethrow; //!! must be changed
      // throw handleException(e);
    }
  }
}
