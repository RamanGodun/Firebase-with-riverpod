import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/failures_for_domain_and_presentation/to_ui_failures_x.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data_providers/sign_out_repo_provider.dart';
import '../../domain/auth_use_cases.dart';

part 'sign_out_provider.g.dart';

@riverpod
class SignOut extends _$SignOut {
  @override
  Future<void> build() async {}

  Future<void> signOut() async {
    state = const AsyncLoading();
    final useCase = SignOutUseCase(ref.read(signOutRepoProvider));
    final result = await useCase();

    state = result.fold(
      (f) => AsyncError(f.toUIModel(), StackTrace.current),
      (_) => const AsyncData(null),
    );
  }

  void reset() => state = const AsyncData(null);
}
