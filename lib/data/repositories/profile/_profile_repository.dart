import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/entities/app_user.dart';
import '../../../core/utils_and_services/errors_managing/handle_exception.dart';
import '../../sources/remote/firebase_constants.dart';

/// [ProfileRepository] handles user profile-related operations, such as fetching user data from Firestore.
class ProfileRepository {
  ///
  Future<AppUser> getProfile({required String userID}) async {
    try {
      /// Retrieves the user profile from Firestore based on the provided [userID].
      final DocumentSnapshot appUserDoc =
          await usersCollection.doc(userID).get();

      if (appUserDoc.exists) {
        /// Returns an instance of [AppUser] containing user details.
        return AppUser.fromDoc(appUserDoc);
      }

      throw 'User not found';
    } catch (e) {
      /// Throws a custom exception if the user is not found or if an error occurs.
      throw handleException(e);
    }
  }
}
