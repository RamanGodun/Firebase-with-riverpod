import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/utils/for_riverpod_providers/safe_async_state.dart';
import '../../data_providers/sign_in_repo_provider.dart';
import '../../domain/auth_use_cases.dart';

part 'signin_provider.g.dart';

/// 🧩 [signinProvider] — async notifier that handles user sign-in
/// 🧼 Uses [SafeAsyncState] to prevent post-dispose state updates
/// 🧼 Wraps logic in [AsyncValue.guard] for robust error handling
//----------------------------------------------------------------//
@riverpod
class Signin extends _$Signin with SafeAsyncState<void> {
  /// 🧱 Initializes safe lifecycle tracking
  @override
  FutureOr<void> build() {
    initSafe();
  }

  /// 🔐 Signs in user with provided email and password
  /// - Delegates auth to [SignInUseCase]
  /// - Ensures state is only updated if still mounted
  Future<void> signin({required String email, required String password}) async {
    final repo = ref.read(signInRepoProvider);
    final useCase = SignInUseCase(repo);

    await updateSafely(() => useCase(email: email, password: password));
  }
}
