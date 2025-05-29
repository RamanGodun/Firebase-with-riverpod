import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data_providers/sign_up_repo_provider.dart';
import '../../domain/auth_use_cases.dart';

part 'signup_provider.g.dart';

/// 🧩 [signupProvider] — async notifier that handles sign-up logic
//----------------------------------------------------------------//

@riverpod
class Signup extends _$Signup {
  @override
  FutureOr<void> build() {}

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    //
    state = const AsyncLoading();

    final repo = ref.read(signUpRepoProvider);
    final useCase = SignUpUseCase(repo);

    state = await AsyncValue.guard(
      () => useCase(name: name, email: email, password: password),
    );
    //
  }
}
