import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/shared_modules/errors_handling/utils/for_riverpod/safe_async_state.dart';
import '../../domain/sign_up_use_case_provider.dart';

part 'signup_provider.g.dart';

/// 🧩 [signupProvider] — async notifier for user registration
/// 🧼 Uses [SafeAsyncState] for lifecycle safety
/// 🧼 Exposes `reset()` and `consumeFailure()` for UI feedback
@Riverpod(keepAlive: false)
class Signup extends _$Signup with SafeAsyncState<void> {
  //
  /// 🧱 Initializes safe lifecycle mechanism
  @override
  FutureOr<void> build() {
    initSafe();
  }

  /// 📝 Signs up user with name, email and password
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    final useCase = ref.watch(signUpUseCaseProvider);

    state = await AsyncValue.guard(() async {
      final result = await useCase(
        name: name,
        email: email,
        password: password,
      );
      return result.fold((f) => throw f, (_) => null);
    });
  }

  /// 🧼 Resets state after UI has handled error
  void reset() => state = const AsyncData(null);

  //
}
