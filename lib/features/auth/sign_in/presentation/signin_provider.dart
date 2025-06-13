import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/shared_modules/errors_handling/utils/for_riverpod/safe_async_state.dart';
import '../domain/sign_in_use_case_provider.dart';

part 'signin_provider.g.dart';

/// 🧩 [signinProvider] — async notifier that handles user sign-in
/// 🧼 Uses [SafeAsyncState] to prevent post-dispose state updates
/// 🧼 Wraps logic in [AsyncValue.guard] for robust error handling
//----------------------------------------------------------------//
@Riverpod(keepAlive: false)
class SignIn extends _$SignIn with SafeAsyncState<void> {
  /// 🧱 Initializes safe lifecycle tracking
  @override
  FutureOr<void> build() {
    initSafe();
  }

  /// 🔐 Signs in user with provided email and password
  /// - Delegates auth to [SignInUseCase]
  Future<void> signin({required String email, required String password}) async {
    //
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final useCase = ref.watch(signInUseCaseProvider);
      final result = await useCase(email: email, password: password);
      return result.fold((failure) => throw failure, (_) => null);
    });
  }

  /// 🧼 Resets state to idle after error or submission
  void reset() {
    state = const AsyncData(null);
  }

  //
}
