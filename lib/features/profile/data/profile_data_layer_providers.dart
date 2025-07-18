import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/profile_repo_contract.dart';
import '../data/profile_repo_impl.dart';
import '../data/remote_data_source.dart';

part 'profile_data_layer_providers.g.dart';

/// 🧩 [profileRepoProvider] — provides instance of [ProfileRepoImpl]
/// 🧠 Injects [IProfileRemoteDataSource] from [profileRemoteDataSourceProvider]
/// ✅ Adds caching, failure mapping, and DTO → Entity conversion
//
@riverpod
IProfileRepo profileRepo(Ref ref) {
  final remote = ref.watch(profileRemoteDataSourceProvider);
  return ProfileRepoImpl(remote);
}

////

////

/// 🔌 [profileRemoteDataSourceProvider] — provides instance of [ProfileRemoteDataSourceImpl]
/// 🧱 Handles direct Firestore access for fetching or creating user profile
//
@riverpod
IProfileRemoteDataSource profileRemoteDataSource(Ref ref) =>
    ProfileRemoteDataSourceImpl();
