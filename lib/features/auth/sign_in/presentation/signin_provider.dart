import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain_and_data/sign_in_repo.dart';
import '../domain_and_data/_sign_in_use_case.dart';

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

    final repo = ref.read(authRepoProvider); 
    final useCase = SignInUseCase(repo);

    state = await AsyncValue.guard(
      () => useCase(email: email, password: password),
    );
  }
}
