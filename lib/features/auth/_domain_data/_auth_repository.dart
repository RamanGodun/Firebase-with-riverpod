import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/config/firebase/firebase_constants.dart';

/// 🧩 [AuthRepository] — abstraction for all Firebase auth logic
/// 🧼 Wraps common operations: sign in, sign up, reset password, etc.
//----------------------------------------------------------------//

class AuthRepository {
  /// 🔎 Returns currently signed-in user
  User? get currentUser => fbAuth.currentUser;

  /// 🆕 Creates user with email/password and stores basic info in Firestore
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await fbAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user!;
      await usersCollection.doc(user.uid).set({'name': name, 'email': email});
    } catch (e) {
      // throw handleException(e);
    }
  }

  /// 🔐 Signs user in using email and password
  Future<void> signin({required String email, required String password}) async {
    try {
      await fbAuth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      // throw handleException(e);
    }
  }

  /// 🔓 Signs out current user
  Future<void> signout() async {
    try {
      await fbAuth.signOut();
    } catch (e) {
      // throw handleException(e);
    }
  }

  /// 🔁 Updates password for the current user
  Future<void> changePassword(String password) async {
    try {
      await currentUser!.updatePassword(password);
    } catch (e) {
      // throw handleException(e);
    }
  }

  /// 📩 Sends a reset password email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await fbAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      // throw handleException(e);
    }
  }

  /// 📧 Sends a verification email to the current user
  Future<void> sendEmailVerification() async {
    try {
      await currentUser!.sendEmailVerification();
    } catch (e) {
      // throw handleException(e);
    }
  }

  /// 🔁 Reloads user state (to update verification status, etc.)
  Future<void> reloadUser() async {
    try {
      await currentUser!.reload();
    } catch (e) {
      // throw handleException(e);
    }
  }

  /// ✅ Reauthenticates the user for sensitive operations (e.g. password change)
  Future<void> reauthenticateWithCredential(
    String email,
    String password,
  ) async {
    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      await currentUser!.reauthenticateWithCredential(credential);
    } catch (e) {
      // throw handleException(e);
    }
  }
}
