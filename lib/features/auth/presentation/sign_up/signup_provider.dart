import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/utils/for_riverpod_providers/safe_async_state.dart';
import '../../data_providers/sign_up_repo_provider.dart';
import '../../domain/auth_use_cases.dart';

part 'signup_provider.g.dart';

/// 🧩 [signupProvider] — async notifier that handles user registration
/// 🧼 Uses [SafeAsyncState] to protect state updates after disposal
/// 🧼 Leverages [AsyncValue.guard] for safe error propagation
//----------------------------------------------------------------//
@riverpod
class Signup extends _$Signup with SafeAsyncState<void> {
  /// 🧱 Initializes safe state mechanism
  @override
  FutureOr<void> build() {
    initSafe();
  }

  /// 📝 Registers a new user using name, email, and password
  /// - Calls [SignUpUseCase] through injected repository
  /// - Automatically catches and exposes errors via [AsyncValue.guard]
  /// - Updates state only if notifier is still mounted
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final repo = ref.read(signUpRepoProvider);
    final useCase = SignUpUseCase(repo);

    await updateSafely(
      () => useCase(name: name, email: email, password: password),
    );
  }
}
