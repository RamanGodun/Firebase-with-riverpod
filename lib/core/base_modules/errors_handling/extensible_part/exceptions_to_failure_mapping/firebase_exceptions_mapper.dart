part of '../../core_of_module/_run_errors_handling.dart';

/// 🗺️ [_firebaseFailureMap] — Maps Firebase error codes to domain [Failure]s
/// ✅ Injects original message as fallback (used when no localization is available)
/// ✅ Add more codes from [FirebaseCodes] as needed
/// ✅ Covers both FirebaseAuth & Firestore codes
//
final _firebaseFailureMap = <String, Failure Function(String?)>{
  ///
  ///
  FirebaseCodes.invalidCredential:
      (msg) => Failure(type: const InvalidCredentialFirebaseFT(), message: msg),

  ///
  FirebaseCodes.emailAlreadyInUse:
      (msg) => Failure(type: const EmailAlreadyInUseFirebaseFT(), message: msg),

  ///
  FirebaseCodes.operationNotAllowed:
      (msg) =>
          Failure(type: const OperationNotAllowedFirebaseFT(), message: msg),

  ///
  FirebaseCodes.requiresRecentLogin:
      (msg) =>
          Failure(type: const RequiresRecentLoginFirebaseFT(), message: msg),

  ///
  FirebaseCodes.tooManyRequests:
      (msg) => Failure(type: const TooManyRequestsFirebaseFT(), message: msg),

  ///
  FirebaseCodes.userDisabled:
      (msg) => Failure(type: const UserDisabledFirebaseFT(), message: msg),

  ///
  FirebaseCodes.userNotFound:
      (msg) => Failure(type: const UserNotFoundFirebaseFT(), message: msg),

  ///
  FirebaseCodes.networkRequestFailed:
      (msg) => FailureFactory.network(message: msg),

  //
};

////

////

/// 🔒 [FirebaseCodes] — Firebase exception codes (used for map lookup)
/// ✅ Centralized registry of Firebase error codes
/// ✅ Prevents string duplication and typos across layers
//
sealed class FirebaseCodes {
  ///--------------------
  //
  static const invalidCredential = 'invalid-credential';
  static const emailAlreadyInUse = 'email-already-in-use';
  static const operationNotAllowed = 'operation-not-allowed';
  static const requiresRecentLogin = 'requires-recent-login';
  static const tooManyRequests = 'too-many-requests';
  static const userDisabled = 'user-disabled';
  static const userNotFound = 'user-not-found';
  static const networkRequestFailed = 'network-request-failed';

  //
}
