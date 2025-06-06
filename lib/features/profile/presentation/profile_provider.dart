import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/utils/for_riverpod/result_handlers_for_riverpod/for_result_notifier_x.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/shared_layers/shared_domain/entities/app_user.dart';
import '../../../core/shared_modules/errors_handling/failures_for_domain_and_presentation/failure_ui_model.dart';
import '../../../core/shared_modules/errors_handling/utils/consumable.dart';
import '../domain_and_data/profile_use_case_provider.dart';

part 'profile_provider.g.dart';

/// 🧩 [profileProvider] — state manager, that delegates logic to use case.
//----------------------------------------------------------------
@riverpod
class Profile extends _$Profile {
  /// 💥 Holds the last failure for contextual UI dialog
  Consumable<FailureUIModel>? _lastFailure;

  /// 🧼 Called by `context.listenProfileFailure(...)`
  FailureUIModel? consumeFailure() => _lastFailure?.consume();

  /// 🧩 Fetches user data via [GetProfileUseCase]
  /// ✅ Handles error via `.guardAndConsume(...)`
  @override
  FutureOr<AppUser> build(String uid) async {
    final useCase = ref.watch(getProfileUseCaseProvider);
    return await useCase(
      uid,
    ).guardAndConsume(onFailure: (uiFailure) => _lastFailure = uiFailure);
  }
}
