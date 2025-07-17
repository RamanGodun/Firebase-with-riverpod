import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/profile_repo_contract.dart';
import '../data/profile_repo_impl.dart';
import '../data/remote_data_source.dart';

part 'profile_repo_provider.g.dart';

/// 🧩 [profileRepoProvider] — provides [ProfileRepoImpl] with injected remote data source
/// 🧼 Used by use cases to access user profile with caching and failure mapping
//
@riverpod
IProfileRepo profileRepo(Ref ref) {
  ///------------------------------
  //
  final remote = ProfileRemoteDataSourceImpl();
  return ProfileRepoImpl(remote);
  //
}
