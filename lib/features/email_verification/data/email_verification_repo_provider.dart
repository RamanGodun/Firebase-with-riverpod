import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/email_verification_repo_contract.dart';
import 'email_verification_repo_impl.dart';

part 'email_verification_repo_provider.g.dart';

/// 🧩 [emailVerificationRepoProvider] — provides instance of [IUserValidationRepoImpl]
/// 🧼 Dependency injection for email verification functionality
//
@riverpod
IUserValidationRepo emailVerificationRepo(Ref ref) => IUserValidationRepoImpl();
