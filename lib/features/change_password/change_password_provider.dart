import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/auth/auth_repository_provider.dart';

part 'change_password_provider.g.dart';

/// **Change Password Provider**
/// A Riverpod provider responsible for handling the change password feature.
/// - **Manages state** using `AsyncValue<void>`
/// - **Calls** [AuthRepository] to execute the password change.
/// - **Optimized for performance** with `AsyncValue.guard()`

@riverpod
class ChangePassword extends _$ChangePassword {
  /// **Build method**
  /// Not utilized here but required by Riverpod's class-based generator.
  @override
  FutureOr<void> build() {}

  /// **Change Password Function**
  ///
  /// - Sets state to **loading** before starting the operation.
  /// - Calls [AuthRepository.changePassword] to update the password.
  /// - Uses `AsyncValue.guard()` to safely manage errors and update state.
  Future<void> changePassword(String password) async {
    state = const AsyncLoading<void>();

    state = await AsyncValue.guard<void>(
      () => ref.read(authRepositoryProvider).changePassword(password),
    );
  }
}
