import '../../../../core/utils_shared/type_definitions.dart';
import 'i_repo.dart';

/// 📦 [SignInUseCase] — Handles user authentication logic, using [ISignInRepo]
//
final class SignInUseCase {
  ///-------------------
  //
  final ISignInRepo authRepo;
  const SignInUseCase(this.authRepo);
  //
  /// 🔐 Signs in with provided credentials
  ResultFuture<void> call({required String email, required String password}) =>
      authRepo.signIn(email: email, password: password);
  //
}

////

////

/// 📦 [SignOutUseCase] — Handles sign-out logic via [ISignOutRepo]
//
final class SignOutUseCase {
  ///--------------------
  //
  final ISignOutRepo repo;
  const SignOutUseCase(this.repo);
  //
  ResultFuture<void> call() => repo.signOut();
  //
}

////

////

/// 📦 [SignUpUseCase] — Handles user registration via [ISignUpRepo]
//
final class SignUpUseCase {
  ///-------------------
  //
  final ISignUpRepo repo;
  const SignUpUseCase(this.repo);
  //
  /// 🔐 Register a new user and returns result
  ResultFuture<void> call({
    required String name,
    required String email,
    required String password,
  }) => repo.signup(name: name, email: email, password: password);
  //
}
