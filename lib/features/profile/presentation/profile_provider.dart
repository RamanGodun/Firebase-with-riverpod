import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/shared_layers/shared_domain/entities/app_user.dart';
import '../../../core/shared_modules/errors_handling/utils/for_riverpod/safe_async_state.dart';
import '../domain_and_data/profile_use_case_provider.dart';

part 'profile_provider.g.dart';

/// 👤 [profileProvider] — async notifier that fetches user profile
/// 🧼 Declarative-only approach, throws [Failure] and is handled in `.listenFailure(...)`
/// 🧼 Compatible with `.family` and avoids breaking [SafeAsyncState] limitations

@riverpod
class Profile extends _$Profile {
  //----------------------------

  @override
  Future<AppUser> build(String uid) async {
    final useCase = ref.watch(getProfileUseCaseProvider);
    final result = await useCase(uid);
    return result.fold((f) => throw f, (user) => user);
  }

  /// ♻️ Refetch user manually (e.g. pull-to-refresh)
  Future<void> refresh() async {
    final uid = this.uid;
    final useCase = ref.read(getProfileUseCaseProvider);

    state = await AsyncValue.guard(() async {
      final result = await useCase(uid);
      return result.fold((f) => throw f, (user) => user);
    });
  }

  /// 🧼 Optional reset (usually after logout)
  void reset() => ref.invalidateSelf();
  /*
? or 
 void reset() => ref.invalidateSelf();
 */

  //
}
