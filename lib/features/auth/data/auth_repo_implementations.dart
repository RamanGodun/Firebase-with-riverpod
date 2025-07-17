import 'package:firebase_with_riverpod/core/base_modules/errors_handling/utils/failure_handling.dart';
import '../../../core/utils_shared/type_definitions.dart';
import '../../profile/data/data_transfer_objects/user_dto_factories_x.dart';
import '../domain/auth_repo_contracts.dart';
import 'auth_remote_data_source.dart';

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
          .executeWithFailureHandling();
}

////

////

/// 🧩 [SignOutRepoImpl] — sign-out from [IAuthRemoteDataSource] with errors mapping
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

////

////

/// 🧩 [SignOutRepoImpl] — sign-up in [IAuthRemoteDataSource] with errors mapping and "ENTITY->DTO" converting
//
final class SignUpRepoImpl implements ISignUpRepo {
  ///---------------------------------------------
  //
  final IAuthRemoteDataSource _remote;
  const SignUpRepoImpl(this._remote);
  //
  @override
  ResultFuture<void> signup({
    required String name,
    required String email,
    required String password,
  }) =>
      (() async {
        final userCredential = await _remote.signUp(
          email: email,
          password: password,
        );
        final user = userCredential.user!;
        //
        /// ✅ Create DTO
        final dto = UserDTOFactories.newUser(
          id: user.uid,
          name: name,
          email: email,
        );
        // 💾 Save in remote database
        await _remote.saveUserDTO(dto);
        //
      }).executeWithFailureHandling();
}
