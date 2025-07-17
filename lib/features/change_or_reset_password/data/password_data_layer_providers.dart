import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/repo_contract.dart';
import 'password_actions_remote_data_source.dart';
import 'password_repo_impl.dart';

part 'password_data_layer_providers.g.dart';

//
// @riverpod
// IPasswordRepo passwordRepo(Ref ref) => PasswordRepoImpl();

@riverpod
IPasswordRemoteDataSource passwordRemoteDataSource(Ref ref) =>
    PasswordRemoteDataSourceImpl();

/// 🧩 [passwordRepoProvider] — provides instance of [PasswordRepoImpl]
/// 🧼 Dependency injection for all password-related functionality
@riverpod
IPasswordRepo passwordRepo(Ref ref) =>
    PasswordRepoImpl(ref.watch(passwordRemoteDataSourceProvider));
