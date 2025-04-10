import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../domain/entities/app_user.dart';
import '../../../utils_and_services/errors_managing/handle_exception.dart';
import '../auth/sources/remote/consts/firebase_constants.dart';

/// **Profile Repository**
///
/// Handles user profile-related operations, such as fetching user data from Firestore.
class ProfileRepository {
  /// **Fetch User Profile**
  ///
  /// Retrieves the user profile from Firestore based on the provided [uid].
  ///
  /// - **Returns:** An instance of [AppUser] containing user details.
  /// - **Throws:** A custom exception if the user is not found or if an error occurs.
  Future<AppUser> getProfile({required String uid}) async {
    try {
      final DocumentSnapshot appUserDoc = await usersCollection.doc(uid).get();

      if (appUserDoc.exists) {
        return AppUser.fromDoc(appUserDoc);
      }

      throw 'User not found';
    } catch (e) {
      throw handleException(e);
    }
  }
}
