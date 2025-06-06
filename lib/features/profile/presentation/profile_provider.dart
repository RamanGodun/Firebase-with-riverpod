import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/utils/dsl_result_handlers/result_handlers_for_riverpod/for_result_notifier_x.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/shared_layers/shared_domain/entities/app_user.dart';
import '../../../core/shared_modules/errors_handling/failures_for_domain_and_presentation/failure_ui_model.dart';
import '../../../core/shared_modules/errors_handling/utils/consumable.dart';
import '../domain_and_data/_profile_use_case.dart';
import '../domain_and_data/profile_repo_provider.dart';

part 'profile_provider.g.dart';

/// 🧩 [profileProvider] — state manager, that delegates logic to use case.
//----------------------------------------------------------------
@riverpod
class Profile extends _$Profile {
  Consumable<FailureUIModel>? _lastFailure;

  FailureUIModel? consumeFailure() => _lastFailure?.consume();

  @override
  FutureOr<AppUser> build(String uid) async {
    final repo = ref.watch(profileRepoProvider);
    final useCase = GetProfileUseCase(repo);

    return await useCase(
      uid,
    ).guardAndConsume(onFailure: (uiFailure) => _lastFailure = uiFailure);
  }
}
