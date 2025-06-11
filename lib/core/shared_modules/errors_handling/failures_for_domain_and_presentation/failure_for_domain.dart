import 'package:equatable/equatable.dart';
import 'enums.dart';

/// 🔥 [Failure] — Domain abstraction for all app-level errors.
/// ✅ Used throughout AZER: [Either<Failure, T>]
/// ✅ Implements sealed class + accessors for message, code, key
//--------------------------------------------------------------------
abstract class Failure extends Equatable {
  //
  final String message;
  final String? translationKey;
  final dynamic statusCode;
  final String? code;

  const Failure._({
    required this.message,
    this.translationKey,
    this.statusCode,
    this.code,
  });

  @override
  List<Object?> get props => [message, translationKey, statusCode, code];
}

///
// ────────────────────────
/// 🚨 Subclasses of [Failure]
// ────────────────────────
///

/// 🌐 [ApiFailure] — HTTP/API-level failures (non-auth)
final class ApiFailure extends Failure {
  ApiFailure({required int super.statusCode, required super.message})
    : super._(code: 'API', translationKey: FailureKey.unknown.translationKey);
}

/// 📡 [NetworkFailure] — connectivity issues (no connection / timeout)
final class NetworkFailure extends Failure {
  NetworkFailure({required super.message, required FailureKey translationKey})
    : super._(
        statusCode: ErrorPlugin.httpClient.code,
        code: 'NETWORK',
        translationKey: translationKey.translationKey,
      );
}

/// 🔒 [UnauthorizedFailure] — 401 token expired / not logged in
final class UnauthorizedFailure extends Failure {
  UnauthorizedFailure({
    required super.message,
    FailureKey translationKey = FailureKey.unauthorized,
  }) : super._(
         statusCode: 401,
         code: 'UNAUTHORIZED',
         translationKey: translationKey.translationKey,
       );
}

/// 🔥 [FirebaseFailure] — general firebase-related issues
final class FirebaseFailure extends Failure {
  FirebaseFailure({
    required super.message,
    FailureKey translationKey = FailureKey.firebaseGeneric,
  }) : super._(
         statusCode: ErrorPlugin.firebase.code,
         code: 'FIREBASE',
         translationKey: translationKey.translationKey,
       );
}

/// 🧠 [UseCaseFailure] — validation / business logic violation
final class UseCaseFailure extends Failure {
  UseCaseFailure({required super.message})
    : super._(
        statusCode: ErrorPlugin.useCase.code,
        code: 'USE_CASE',
        translationKey: FailureKey.unknown.translationKey,
      );
}

/// ⚙️ [GenericFailure] — system/platform issues (plugin missing, etc.)
final class GenericFailure extends Failure {
  final ErrorPlugin plugin;

  GenericFailure({
    required this.plugin,
    required String super.code,
    required super.message,
    FailureKey? translationKey,
  }) : super._(
         statusCode: plugin.code,
         translationKey: translationKey?.translationKey,
       );

  @override
  List<Object?> get props => super.props..add(plugin);
}

/// 🧊 [CacheFailure] — local storage, preferences, or disk read/write error
final class CacheFailure extends Failure {
  CacheFailure({required super.message})
    : super._(
        statusCode: 'CACHE',
        code: 'CACHE',
        translationKey: FailureKey.unknown.translationKey,
      );
}

/// ❓ [UnknownFailure] — unhandled, uncategorized fallback
final class UnknownFailure extends Failure {
  UnknownFailure({
    required super.message,
    FailureKey translationKey = FailureKey.unknown,
  }) : super._(
         statusCode: 'UNKNOWN',
         translationKey: translationKey.translationKey,
       );
}

/// 🔍 [FirestoreDocMissingFailure] — document exists but has wrong structure
final class FirestoreDocMissingFailure extends FirebaseFailure {
  FirestoreDocMissingFailure()
    : super(
        message: 'Expected document is missing in Firestore.',
        translationKey: FailureKey.firebaseDocMissing,
      );
}

/// ❌ [FirebaseUserMissingFailure] — FirebaseAuth.currentUser is null
final class FirebaseUserMissingFailure extends FirebaseFailure {
  FirebaseUserMissingFailure()
    : super(
        message: 'FirebaseAuth.currentUser is null. User not signed in.',
        translationKey: FailureKey.firebaseGeneric,
      );
}
