import 'package:firebase_auth/firebase_auth.dart';
import '../../entities/custom_error.dart';

/// Handles exceptions and converts them into a structured [CustomError].
/// This function catches different types of Firebase-related exceptions and converts them
/// into a custom error format for better error handling and debugging.
/// [Exception] - Catches any other unknown errors and provides a generic response.
CustomError handleException(e) {
  try {
    throw e;
  }
  /// [FirebaseAuthException] handles authentication-related errors.
  on FirebaseAuthException catch (e) {
    return CustomError(
      code: e.code,
      message: e.message ?? 'Invalid credential',
      plugin: e.plugin,
    );
  }
  /// [FirebaseException] handles general Firebase-related errors.
  on FirebaseException catch (e) {
    return CustomError(
      code: e.code,
      message: e.message ?? 'Firebase Error',
      plugin: e.plugin,
    );
  }
  /// Returns a [CustomError] containing the error details.
  catch (e) {
    return CustomError(
      code: 'Exception',
      message: e.toString(),
      plugin: 'Unknown error',
    );
  }
}
