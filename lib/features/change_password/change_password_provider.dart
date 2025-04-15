import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/auth/auth_repository_provider.dart';

part 'change_password_provider.g.dart';

/// 🔐 [ChangePassword] — Riverpod `AsyncNotifier`
/// Handles the "change password" flow, updates the state using [AsyncValue]
//--------------------------------------------------------//
@riverpod
class ChangePassword extends _$ChangePassword {
  /// 🧱 Required method by Riverpod’s codegen (not used here)
  @override
  FutureOr<void> build() {}

  /// 🔁 Triggers password change operation
  Future<void> changePassword(String password) async {
    state = const AsyncLoading();

    /// Uses `AsyncValue.guard()` for safe error handling
    state = await AsyncValue.guard(
      /// Delegates actual logic to [AuthRepository.changePassword]
      () => ref.read(authRepositoryProvider).changePassword(password),
    );
  }
}
