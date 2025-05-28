import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../_data/sign_up_repo.dart';
import '../../_domain/sign_up_use_case.dart';

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
    state = const AsyncLoading();
    final repo = ref.read(signUpRepoProvider);
    final useCase = SignUpUseCase(repo);

    state = await AsyncValue.guard(
      () => useCase(name: name, email: email, password: password),
    );
  }
}
