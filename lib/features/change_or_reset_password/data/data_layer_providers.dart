import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/i_repo.dart';
import 'i_remote_database.dart';
import 'remote_database_impl.dart';
import 'repo_impl.dart';

part 'data_layer_providers.g.dart';

/// 🧩 [passwordRemoteDataSourceProvider] — provides implementation of [IPasswordRemoteDataSource]
/// ✅ Low-level data access for password-related Firebase actions
//
@riverpod
IPasswordRemoteDataSource passwordRemoteDataSource(Ref ref) =>
    PasswordRemoteDataSourceImpl();

/// 🧩 [passwordRepoProvider] — provides implementation of [IPasswordRepo]
/// 🧼 Adds failure mapping on top of remote data source
/// ✅ Used by domain layer use cases
//
@riverpod
IPasswordRepo passwordRepo(Ref ref) =>
    PasswordRepoImpl(ref.watch(passwordRemoteDataSourceProvider));
