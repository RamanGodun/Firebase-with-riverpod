import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/shared_modules/errors_handling/utils/for_riverpod/failure_utils.dart';
import '../../../core/utils/typedef.dart';
import '../data_providers/sign_out_repo_provider.dart';
import 'auth_repos.dart';

part 'sign_out_use_case_provider.g.dart';

@Riverpod(keepAlive: false)
SignOutUseCase signOutUseCase(Ref ref) {
  final repo = ref.watch(signOutRepoProvider);
  return SignOutUseCase(repo);
}

///

/// 📦 [SignOutUseCase] — encapsulates sign-out logic
/// 🧼 Invokes Firebase sign-out via [ISignOutRepo]
//---------------------------------------------------
final class SignOutUseCase {
  final ISignOutRepo repo;
  const SignOutUseCase(this.repo);

  ResultFuture<void> call() async {
    //
    try {
      await repo.signOut();
      return right(null);
    } catch (e, st) {
      return left(mapToFailure(e, st));
    }
  }
}
