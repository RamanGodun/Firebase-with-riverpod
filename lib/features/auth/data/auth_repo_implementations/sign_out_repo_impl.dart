import 'package:firebase_with_riverpod/core/base_modules/errors_handling/utils/failure_handling.dart';
import '../../../../core/utils_shared/type_definitions.dart';
import '../../domain/i_repo.dart';
import '../i_remote_database.dart';

/// 🧩 [SignOutRepoImpl] — sign-out from [IAuthRemoteDataSource] with errors mapping
//
final class SignOutRepoImpl implements ISignOutRepo {
  ///-----------------------------------------------
  //
  final IAuthRemoteDataSource _remote;
  const SignOutRepoImpl(this._remote);
  //
  @override
  ResultFuture<void> signOut() =>
      (() => _remote.signOut()).executeWithFailureHandling();
}
