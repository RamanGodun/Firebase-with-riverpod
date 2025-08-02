part of '../../core_of_module/failure_entity.dart';

/// 🔥 [FirebaseFailure] — general firebase-related issues
//
final class FirebaseFailure extends Failure {
  ///---------------------------------------
  //
  FirebaseFailure({
    required super.message,
    FailureTranslationKeys translationKey =
        FailureTranslationKeys.firebaseGeneric,
  }) : super._(
         statusCode: FailureSource.firebase.code,
         code: 'FIREBASE',
         translationKey: translationKey.translationKey,
       );
  //
}

////

/// ❌ [FirebaseUserMissingFailure] — FirebaseAuth.currentUser is null
//
final class FirebaseUserMissingFailure extends FirebaseFailure {
  ///---------------------------------------
  //
  FirebaseUserMissingFailure()
    : super(
        message: 'FirebaseAuth.currentUser is null. User not signed in.',
        translationKey: FailureTranslationKeys.firebaseGeneric,
      );
  //
}

////

/// 🔍 [FirestoreDocMissingFailure] — document exists but has wrong structure
//
final class FirestoreDocMissingFailure extends FirebaseFailure {
  ///---------------------------------------
  //
  FirestoreDocMissingFailure()
    : super(
        message: 'Expected document is missing in Firestore.',
        translationKey: FailureTranslationKeys.firebaseDocMissing,
      );
  //
}
