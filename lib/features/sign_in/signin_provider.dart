import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/repositories/auth/auth_repository_provider.dart';

part 'signin_provider.g.dart';

/// [Signin] Provider, responsible for handling user sign-in.
@riverpod
class Signin extends _$Signin {
  @override
  FutureOr<void> build() {}

  /// Calls [AuthRepository.signin] with provided credentials.
  Future<void> signin({required String email, required String password}) async {
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard<void>(
      () => ref
          .read(authRepositoryProvider)
          .signin(email: email, password: password),
    );
  }
}
