import 'package:firebase_auth/firebase_auth.dart' show User;
import '../../core/base_modules/errors_handling/extensible_part/failure_factory.dart';
import 'firebase_constants.dart';

/// 🧩 [AuthUserUtils] — centralized utils for accessing current user
/// 🛡️ Guarantees null-safe usage of FirebaseAuth.currentUser
/// 🧼 Use in Repositories or UseCases

abstract final class AuthUserUtils {
  //-------------------------------

  /// 👤 Returns current user or throws [FirebaseUserMissingFailure]
  static User get currentUserOrThrow {
    final user = FirebaseConstants.fbAuth.currentUser;
    if (user == null) throw throw FailureFactory.firebaseUserMissing;
    return user;
  }

  /// ❓ Returns current user if present, or `null`
  static User? get currentUserOrNull => FirebaseConstants.fbAuth.currentUser;

  /// 🆔 Returns user UID or throws
  static String get uid => currentUserOrThrow.uid;

  /// 📬 Returns user email or throws
  static String get email => currentUserOrThrow.email ?? 'unknown';

  // (here can be add methods, tokens, refresh ...)
}
