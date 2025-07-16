import 'package:firebase_with_riverpod/core/shared_domain_layer/base_use_case.dart';
import '../../../../core/utils_shared/type_definitions.dart';
import 'auth_repo_contracts.dart';

/// 📦 [SignInUseCase] — encapsulates sign-in process
/// 🧼 Handles user authentication using [ISignInRepo]

final class SignInUseCase {
  ///-------------------
  //
  final ISignInRepo authRepo;
  const SignInUseCase(this.authRepo);
  //
  /// 🔐 Signs in with provided credentials
  ResultFuture<void> call({required String email, required String password}) =>
      (() => authRepo.signIn(email: email, password: password))
          .executeWithFailureHandling();
  //
}

////

////

/// 📦 [SignOutUseCase] — encapsulates sign-out logic
/// 🧼 Invokes Firebase sign-out via [ISignOutRepo]

final class SignOutUseCase {
  ///--------------------
  //
  final ISignOutRepo repo;
  const SignOutUseCase(this.repo);
  //
  ResultFuture<void> call() =>
      (() => repo.signOut()).executeWithFailureHandling();
  //
}

////

////

/// 📦 [SignUpUseCase] — encapsulates user registration
/// 🧼 Creates Firebase user and stores user profile via [ISignUpRepo]

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
  }) =>
      (() => repo.signup(name: name, email: email, password: password))
          .executeWithFailureHandling();
  //
}
