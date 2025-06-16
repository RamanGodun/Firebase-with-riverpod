import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/profile_repo_contract.dart';
import '../data/profile_repo_impl.dart';
import '../data/remote_data_source.dart';

part 'profile_repo_provider.g.dart';

/// DI binding for repository + data source.

@riverpod
IProfileRepo profileRepo(Ref ref) {
  // ─────────────────────────────

  return ProfileRepoImpl(ProfileRemoteDataSourceImpl());
}
