import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/entities/app_user.dart';
import '../../../core/utils_and_services/errors_managing/handle_exception.dart';
import '../../sources/remote/firebase_constants.dart';

/// 🧩 [ProfileRepository] — abstraction for user profile fetching from Firestore
/// 🧼 Handles retrieving user data by UID
//----------------------------------------------------------------//

class ProfileRepository {
  /// 🧾 Fetches user profile by [userID] from Firestore
  Future<AppUser> getProfile({required String userID}) async {
    try {
      final DocumentSnapshot doc = await usersCollection.doc(userID).get();

      if (!doc.exists) {
        throw 'User not found';
      }

      return AppUser.fromDoc(doc);
    } catch (e) {
      throw handleException(e);
    }
  }
}
