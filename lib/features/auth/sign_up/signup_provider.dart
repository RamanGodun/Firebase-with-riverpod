import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../_domain_data/auth_repository_providers.dart';

part 'signup_provider.g.dart';

/// 🧩 [signupProvider] — async notifier that handles sign-up logic
//----------------------------------------------------------------//

@riverpod
class Signup extends _$Signup {
  Object? _key;

  @override
  FutureOr<void> build() {
    _key = Object();

    ref.onDispose(() {
      _key = null;
    });
  }

  /// 📝 Registers a new user using email, password and name
  /// - Uses [_key] to avoid state updates after disposal
  /// - Updates state via [AsyncValue.guard] for error-safe flow
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    final currentKey = _key;

    final newState = await AsyncValue.guard(
      () => ref
          .read(authRepositoryProvider)
          .signup(name: name, email: email, password: password),
    );

    if (currentKey == _key) {
      state = newState;
    }
  }
}
