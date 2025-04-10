import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/data/repositories/auth/auth_repository_provider.dart';

part 'signup_provider.g.dart';

/// **Signup Provider**
///
/// A Riverpod provider that handles user registration.
/// - Manages sign-up requests and state.
/// - Ensures **safe state updates** by using `_key` to avoid race conditions.
/// - Calls [AuthRepository] for authentication.
///
/// Usage:
/// ```dart
/// ref.read(signupProvider.notifier).signup(
///   name: userName,
///   email: userEmail,
///   password: userPassword,
/// );
/// ```
@riverpod
class Signup extends _$Signup {
  /// A unique key to track active state
  /// Helps prevent state updates after disposal.
  Object? _key;

  /// **Build method**
  ///
  /// - Initializes `_key` to track the provider lifecycle.
  /// - Listens for disposal to clean up `_key` and prevent memory leaks.
  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() {
      print('[signupProvider] disposed');
      _key = null;
    });
  }

  /// **Signup Function**
  ///
  /// - Sets state to **loading** before attempting user registration.
  /// - Calls [AuthRepository.signup] to create a new account.
  /// - Uses `_key` to ensure state updates **only if the provider is still active**.
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading<void>();
    final key = _key; // Store the current key to track active state.

    final newState = await AsyncValue.guard<void>(
      () => ref
          .read(authRepositoryProvider)
          .signup(name: name, email: email, password: password),
    );

    // Ensure the state is updated only if the provider is still active.
    if (key == _key) {
      state = newState;
    }
  }
}
