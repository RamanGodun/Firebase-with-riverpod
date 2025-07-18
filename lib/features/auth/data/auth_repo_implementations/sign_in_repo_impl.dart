import 'package:firebase_with_riverpod/core/base_modules/errors_handling/utils/failure_handling.dart';
import '../../../../core/utils_shared/type_definitions.dart';
import '../../domain/i_repo.dart';
import '../i_remote_database.dart';

/// 🧩 [SignInRepoImpl] — sign-in in [IAuthRemoteDataSource] with errors mapping
//
final class SignInRepoImpl implements ISignInRepo {
  ///---------------------------------------------
  //
  final IAuthRemoteDataSource _remote;
  const SignInRepoImpl(this._remote);
  //
  @override
  ResultFuture<void> signIn({
    required String email,
    required String password,
  }) =>
      (() => _remote.signIn(email: email, password: password))
          .runWithErrorHandling();
}
