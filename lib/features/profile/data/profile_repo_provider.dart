import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/profile_repo_contract.dart';
import '../data/profile_repo_impl.dart';
import '../data/remote_data_source.dart';

part 'profile_repo_provider.g.dart';

/// 📦 [profileRepoProvider] — provides the domain repository via DI
/// 🧩 Combines implementation with remote data source dependency
/// 🧼 Keeps separation between contract and concrete logic

@riverpod
IProfileRepo profileRepo(Ref ref) {
  ///------------------------------
  //
  // Injects concrete implementation of IProfileRemoteDataSource
  final remote = ProfileRemoteDataSourceImpl();

  // Returns the repository with injected dependency
  return ProfileRepoImpl(remote);

  //
}
