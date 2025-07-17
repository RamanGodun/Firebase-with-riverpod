import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/email_verification_repo_contract.dart';
import 'email_verification_repo_impl.dart';
import 'remote_data_source.dart';

part 'email_verification_repo_provider.g.dart';

/// 📦 [emailVerificationRepoProvider] — provides validated domain repo
/// 🔁 Combines error mapping with remote data source delegation
//
@riverpod
IUserValidationRepo emailVerificationRepo(Ref ref) {
  final remote = ref.watch(userValidationRemoteDataSourceProvider);
  return IUserValidationRepoImpl(remote);
}

/// 🛰️ [userValidationRemoteDataSourceProvider] — provides Firebase-based remote source
//
@riverpod
IUserValidationRemoteDataSource userValidationRemoteDataSource(Ref ref) =>
    IUserValidationRemoteDataSourceImpl();
