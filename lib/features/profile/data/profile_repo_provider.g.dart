// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_repo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profileRepoHash() => r'ac70e940332b55897e6200cf48c379ac0a435390';

/// 📦 [profileRepoProvider] — provides the domain repository via DI
/// 🧩 Combines implementation with remote data source dependency
/// 🧼 Keeps separation between contract and concrete logic
///
/// Copied from [profileRepo].
@ProviderFor(profileRepo)
final profileRepoProvider = AutoDisposeProvider<IProfileRepo>.internal(
  profileRepo,
  name: r'profileRepoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$profileRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProfileRepoRef = AutoDisposeProviderRef<IProfileRepo>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
