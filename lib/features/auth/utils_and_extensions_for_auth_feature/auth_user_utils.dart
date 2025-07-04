import 'package:firebase_auth/firebase_auth.dart' show User;
import '../../../core/app_configs/firebase/firebase_constants.dart';
import '../../../core/foundation/errors_handling/failures/failure_entity.dart';

/// 🧩 [AuthUserUtils] — centralized utils for accessing current user
/// 🛡️ Guarantees null-safe usage of FirebaseAuth.currentUser
/// 🧼 Use in Repositories or UseCases

abstract final class AuthUserUtils {
  //-------------------------------

  /// 👤 Returns current user or throws [FirebaseUserMissingFailure]
  static User get currentUserOrThrow {
    final user = fbAuth.currentUser;
    if (user == null) throw FirebaseUserMissingFailure();
    return user;
  }

  /// ❓ Returns current user if present, or `null`
  static User? get currentUserOrNull => fbAuth.currentUser;

  /// 🆔 Returns user UID or throws
  static String get uid => currentUserOrThrow.uid;

  /// 📬 Returns user email or throws
  static String get email => currentUserOrThrow.email ?? 'unknown';

  // (here can be add methods, tokens, refresh ...)
}
