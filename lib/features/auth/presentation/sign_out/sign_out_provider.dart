import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/utils_shared/safe_async_state.dart';
import '../../../profile/data/data_layer_providers.dart';
import '../../domain/use_cases_providers.dart';

part 'sign_out_provider.g.dart';

/// 🔓 [SignOutProvider] — async notifier for user sign-out
/// 🧼 Uses [SafeAsyncState] for lifecycle safety and cache cleanup
/// 🧼 Wraps result in [AsyncValue.guard]-like error propagation
//
@riverpod
final class SignOut extends _$SignOut with SafeAsyncState<void> {
  ///---------------------------------------------------------

  @override
  Future<void> build() async {
    initSafe();
  }

  /// 🚪 Performs user sign-out via [SignOutUseCase]
  /// 💥 Throws [Failure] on error and clears cached profile on success
  Future<void> signOut() async {
    state = const AsyncLoading();

    final useCase = ref.watch(signOutUseCaseProvider);
    final result = await useCase();

    if (result.isRight) {
      ref.read(profileRepoProvider).clearCache();
    }

    state = result.fold((f) => throw f, (_) => const AsyncData(null));
  }

  /// 🧼 Resets state to idle (null)
  void reset() => state = const AsyncData(null);

  //
}
