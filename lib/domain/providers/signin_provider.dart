import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/data/repositories/auth/auth_repository_provider.dart';

part 'signin_provider.g.dart';

/// **Signin Provider**
///
/// A Riverpod provider responsible for handling user sign-in.
///
/// - **Manages authentication state** using `AsyncValue<void>`.
/// - **Calls** [AuthRepository] to perform user sign-in.
/// - **Ensures error safety** with `AsyncValue.guard()`.
///
/// Usage:
/// ```dart
/// ref.read(signinProvider.notifier).signin(email: userEmail, password: userPassword);
/// ```
@riverpod
class Signin extends _$Signin {
  /// **Build method**
  /// Required by Riverpod’s class-based generator but not utilized here.
  @override
  FutureOr<void> build() {}

  /// **Signin Function**
  ///
  /// - Sets state to **loading** before attempting authentication.
  /// - Calls [AuthRepository.signin] with provided credentials.
  /// - Uses `AsyncValue.guard()` for safe error handling.
  Future<void> signin({required String email, required String password}) async {
    state = const AsyncLoading<void>();

    state = await AsyncValue.guard<void>(
      () => ref
          .read(authRepositoryProvider)
          .signin(email: email, password: password),
    );
  }
}
