import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/failures_for_domain_and_presentation/to_ui_failures_x.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/sign_out_use_case_provider.dart';

part 'sign_out_provider.g.dart';

@riverpod
class SignOut extends _$SignOut {
  @override
  Future<void> build() async {}

  Future<void> signOut() async {
    state = const AsyncLoading();
    final useCase = ref.watch(signOutUseCaseProvider);
    final result = await useCase();

    state = result.fold(
      (f) => AsyncError(f.toUIModel(), StackTrace.current),
      (_) => const AsyncData(null),
    );
  }

  void reset() => state = const AsyncData(null);
}
