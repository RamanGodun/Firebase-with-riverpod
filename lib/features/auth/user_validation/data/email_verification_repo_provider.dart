import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/app_configs/firebase/firebase_constants.dart';
import '../domain/user_validation_repo_contract.dart';

part 'email_verification_repo_provider.g.dart';

/// 🧩 [emailVerificationRepoProvider] — provides instance of [IUserValidationRepoImpl]
/// 🧼 Dependency injection for email verification functionality
@riverpod
IUserValidationRepo emailVerificationRepo(Ref ref) => IUserValidationRepoImpl();

///------------------------------------------------------------------------------------
/// 🧩 [IUserValidationRepoImpl] — concrete implementation of [IUserValidationRepo]
/// 🧼 Handles email verification operations using FirebaseAuth
final class IUserValidationRepoImpl implements IUserValidationRepo {
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
