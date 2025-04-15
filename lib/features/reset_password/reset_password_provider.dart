import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/auth/auth_repository_provider.dart';

part 'reset_password_provider.g.dart';

/// **Reset Password Provider**
///
/// A Riverpod provider responsible for handling the password reset feature.
///
/// - **Manages state** using `AsyncValue<void>`
/// - **Calls** [AuthRepository] to send a password reset email.
/// - **Ensures error safety** with `AsyncValue.guard()`
///

@riverpod
class ResetPassword extends _$ResetPassword {
  /// **Build method**
  /// Required by Riverpod’s class-based generator but not utilized here.
  @override
  FutureOr<void> build() {}

  /// **Reset Password Function**
  ///
  /// - Sets state to **loading** before sending the reset request.
  /// - Calls [AuthRepository.sendPasswordResetEmail] to send a reset email.
  /// - Uses `AsyncValue.guard()` for safe error handling.
  Future<void> resetPassword({required String email}) async {
    state = const AsyncLoading<void>();

    state = await AsyncValue.guard<void>(
      () => ref.read(authRepositoryProvider).sendPasswordResetEmail(email),
    );
  }
}
