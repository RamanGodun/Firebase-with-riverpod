import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/sign_out_repo.dart';
import '../../domain/sign_out_use_case.dart';

part 'sign_out_provider.g.dart';

@riverpod
class SignOut extends _$SignOut {
  @override
  Future<void> build() async {}

  Future<void> signOut() async {
    state = const AsyncLoading();
    final useCase = SignOutUseCase(ref.read(signOutRepoProvider));
    state = await AsyncValue.guard(() => useCase());
  }
}
