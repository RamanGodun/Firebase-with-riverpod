import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/repositories/auth/auth_repository_provider.dart';

part 'signin_provider.g.dart';

/// 🧩 [signinProvider] — async notifier that handles sign in logic
//----------------------------------------------------------------//

@riverpod
class Signin extends _$Signin {
  @override
  FutureOr<void> build() {}

  /// 🚀 Signs user in using email/password credentials
  Future<void> signin({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(authRepositoryProvider)
          .signin(email: email, password: password),
    );
  }
}
