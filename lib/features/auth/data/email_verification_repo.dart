import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/config/firebase/firebase_constants.dart';

part 'email_verification_repo.g.dart';

@riverpod
IEmailVerificationRepo emailVerificationRepo(Ref ref) => EmailVerificationRepoImpl();

abstract interface class IEmailVerificationRepo {
  Future<void> sendEmailVerification();
  Future<void> reloadUser();
  bool isEmailVerified();
}

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
