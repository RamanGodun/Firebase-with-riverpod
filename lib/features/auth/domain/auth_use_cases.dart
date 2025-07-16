import '../../../../core/utils_shared/type_definitions.dart';
import '../../../../core/base_modules/errors_handling/utils/failure_utils.dart';
import 'auth_repo_contracts.dart';

/// 📦 [SignInUseCase] — encapsulates sign-in process
/// 🧼 Handles user authentication using [ISignInRepo]

final class SignInUseCase {
  //----------------------

  final ISignInRepo authRepo;
  const SignInUseCase(this.authRepo);

  // 🔐 Signs in with provided credentials
  ResultFuture<void> call({
    required String email,
    required String password,
  }) async {
    try {
      await authRepo.signIn(email: email, password: password);
      return right(null);
    } catch (e, st) {
      return left(mapToFailure(e, st));
    }
  }

  //
}

////

////

/// 📦 [SignOutUseCase] — encapsulates sign-out logic
/// 🧼 Invokes Firebase sign-out via [ISignOutRepo]

final class SignOutUseCase {
  //-----------------------

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

  //
}

////

////

/// 📦 [SignUpUseCase] — encapsulates user registration
/// 🧼 Creates Firebase user and stores user profile via [ISignUpRepo]

final class SignUpUseCase {
  //----------------------

  final ISignUpRepo repo;
  const SignUpUseCase(this.repo);

  // 🔐 Register a new user and returns result
  ResultFuture<void> call({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await repo.signup(name: name, email: email, password: password);
      return right(null);
    } catch (e, st) {
      return left(mapToFailure(e, st));
    }
  }

  //
}
