import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/config/firebase/firebase_constants.dart';
import '../domain/auth_repos.dart';

part 'email_verification_repo_provider.g.dart';

/// 🧩 [emailVerificationRepoProvider] — provides instance of [EmailVerificationRepoImpl]
/// 🧼 Dependency injection for email verification functionality
@riverpod
IEmailVerificationRepo emailVerificationRepo(Ref ref) =>
    EmailVerificationRepoImpl();

///------------------------------------------------------------------------------------
/// 🧩 [EmailVerificationRepoImpl] — concrete implementation of [IEmailVerificationRepo]
/// 🧼 Handles email verification operations using FirebaseAuth
final class EmailVerificationRepoImpl implements IEmailVerificationRepo {
  @override
  Future<void> sendEmailVerification() async {
    await fbAuth.currentUser!.sendEmailVerification();
  }

  @override
  Future<void> reloadUser() async {
    await fbAuth.currentUser!.reload();
  }

  @override
  bool isEmailVerified() => fbAuth.currentUser?.emailVerified ?? false;
}
