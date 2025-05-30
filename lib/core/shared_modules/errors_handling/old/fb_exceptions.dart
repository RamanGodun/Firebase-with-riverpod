import 'package:firebase_auth/firebase_auth.dart';
import 'custom_error.dart';

/// 🧼 Обробляє [FirebaseAuthException] або повертає default
CustomError handleException(Object error) {
  if (error is FirebaseAuthException) {
    return CustomError(
      code: error.code,
      message: error.message ?? 'Unknown FirebaseAuth error',
      plugin: 'firebase_auth',
    );
  }

  return const CustomError(
    code: 'unknown',
    message: 'An unexpected error occurred',
    plugin: 'unknown',
  );
}
