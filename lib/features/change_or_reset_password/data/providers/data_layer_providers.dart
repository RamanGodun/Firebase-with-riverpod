import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/repo_contract.dart';
import '../password_actions_repo_impl.dart';
import '../remote_database_contract.dart';
import '../remote_database_impl.dart';

part 'data_layer_providers.g.dart';

/// 🧩 [passwordRemoteDataSourceProvider] — provides implementation of [IPasswordRemoteDatabase]
/// ✅ Low-level data access for password-related Firebase actions
//
@riverpod
IPasswordRemoteDatabase passwordRemoteDatabase(Ref ref) =>
    PasswordRemoteDatabaseImpl();

/// 🧩 [passwordRepoProvider] — provides implementation of [IPasswordRepo]
/// 🧼 Adds failure mapping on top of remote data source
/// ✅ Used by domain layer use cases
//
@riverpod
IPasswordRepo passwordRepo(Ref ref) =>
    PasswordRepoImpl(ref.watch(passwordRemoteDatabaseProvider));
