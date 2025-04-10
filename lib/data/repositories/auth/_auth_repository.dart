import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/utils_and_services/errors_managing/handle_exception.dart';
import '../../sources/remote/consts/firebase_constants.dart';

/// **Authentication Repository**
///
/// This repository provides methods for handling authentication-related
/// operations, including signing up, signing in, signing out, and password management.
class AuthRepository {
  /// **Get Current User**
  ///
  /// Returns the currently authenticated user or `null` if not signed in.
  User? get currentUser => fbAuth.currentUser;

  /// **Sign Up**
  ///
  /// Creates a new user with the provided [name], [email], and [password].
  /// The user details are then stored in Firestore.
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

      final signedInUser = userCredential.user!;

      await usersCollection.doc(signedInUser.uid).set({
        'name': name,
        'email': email,
      });
    } catch (e) {
      throw handleException(e);
    }
  }

  /// **Sign In**
  ///
  /// Authenticates a user with the provided [email] and [password].
  Future<void> signin({required String email, required String password}) async {
    try {
      await fbAuth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw handleException(e);
    }
  }

  /// **Sign Out**
  ///
  /// Signs out the currently authenticated user.
  Future<void> signout() async {
    try {
      await fbAuth.signOut();
    } catch (e) {
      throw handleException(e);
    }
  }

  /// **Change Password**
  ///
  /// Updates the current user's password to the new [password].
  Future<void> changePassword(String password) async {
    try {
      await currentUser!.updatePassword(password);
    } catch (e) {
      throw handleException(e);
    }
  }

  /// **Send Password Reset Email**
  ///
  /// Sends a password reset email to the specified [email].
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await fbAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw handleException(e);
    }
  }

  /// **Send Email Verification**
  ///
  /// Sends a verification email to the currently signed-in user.
  Future<void> sendEmailVerification() async {
    try {
      await currentUser!.sendEmailVerification();
    } catch (e) {
      throw handleException(e);
    }
  }

  /// **Reload User**
  ///
  /// Reloads the current user's authentication state.
  Future<void> reloadUser() async {
    try {
      await currentUser!.reload();
    } catch (e) {
      throw handleException(e);
    }
  }

  /// **Reauthenticate with Credentials**
  ///
  /// Reauthenticates the current user using their [email] and [password].
  /// This is required for sensitive operations, such as changing the email or password.
  Future<void> reauthenticateWithCredential(
    String email,
    String password,
  ) async {
    try {
      await currentUser!.reauthenticateWithCredential(
        EmailAuthProvider.credential(email: email, password: password),
      );
    } catch (e) {
      throw handleException(e);
    }
  }
}
