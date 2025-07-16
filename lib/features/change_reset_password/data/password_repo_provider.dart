import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/repo_contract.dart';
import 'password_repo_impl.dart';

part 'password_repo_provider.g.dart';

/// 🧩 [passwordRepoProvider] — provides instance of [PasswordRepoImpl]
/// 🧼 Dependency injection for all password-related functionality
//
@riverpod
IPasswordRepo passwordRepo(Ref ref) => PasswordRepoImpl();
