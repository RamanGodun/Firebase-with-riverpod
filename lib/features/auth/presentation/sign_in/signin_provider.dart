import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/sign_in_repo.dart';
import '../../domain/sign_in_use_case.dart';

part 'signin_provider.g.dart';

/// 🧩 [signinProvider] — async notifier that handles sign in logic
//----------------------------------------------------------------//

@riverpod
class Signin extends _$Signin {
  @override
  FutureOr<void> build() {}

  Future<void> signin({required String email, required String password}) async {
    state = const AsyncLoading();
    final repo = ref.read(signInRepoProvider);
    final useCase = SignInUseCase(repo);

    state = await AsyncValue.guard(
      () => useCase(email: email, password: password),
    );
  }
}
