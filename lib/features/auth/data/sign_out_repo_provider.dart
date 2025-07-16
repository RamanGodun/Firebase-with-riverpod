import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../app_bootstrap_and_config/app_config/firebase/firebase_constants.dart';
import '../../../../core/base_modules/errors_handling/utils/observers/loggers/errors_log_util.dart';
import '../domain/sign_out_repo_contract.dart';

part 'sign_out_repo_provider.g.dart';

/// 🧩 [signOutRepoProvider] — provides instance of [SignOutRepoImpl]
/// 🧼 Dependency injection for sign-out operation

@riverpod
ISignOutRepo signOutRepo(Ref ref) => SignOutRepoImpl();

////

////

/// 🧩 [SignOutRepoImpl] — concrete implementation of [ISignOutRepo]
/// 🧼 Wraps [FirebaseAuth.signOut] with error logging

final class SignOutRepoImpl implements ISignOutRepo {
  ///-----------------------------------------------

  @override
  Future<void> signOut() async {
    try {
      await fbAuth.signOut();
    } catch (e, st) {
      ErrorsLogger.log(e, st);
      rethrow;
    }
  }

  //
}
