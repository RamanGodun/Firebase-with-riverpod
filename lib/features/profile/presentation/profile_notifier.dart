import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/shared_layers/shared_domain/entities/app_user.dart';
import '../../../core/shared_modules/errors_handling/failures_for_domain_and_presentation/failure_ui_model.dart';
import '../../../core/shared_modules/errors_handling/utils/result_aware_handler.dart';
import '../domain_and_data/_profile_use_case.dart';
import '../domain_and_data/profile_repo_provider.dart';

part 'profile_notifier.g.dart';

/// 🧩 [profileProvider] — state manager, that delegates logic to use case.
//----------------------------------------------------------------
@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  //
  final _handler = ResultAwareHandler<AppUser>();
  FailureUIModel? consumeFailure() => _handler.failureUIModel?.consume();

  @override
  FutureOr<AppUser> build(String uid) async {
    final repo = ref.watch(profileRepoProvider);
    final useCase = GetProfileUseCase(repo);

    AppUser? user;
    await _handler.handleResult(useCase.call(uid), (u) => user = u);

    return user!;
  }
}
