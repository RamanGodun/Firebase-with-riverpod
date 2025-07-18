// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_layer_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profileRepoHash() => r'ac70e940332b55897e6200cf48c379ac0a435390';

/// 🧩 [profileRepoProvider] — provides [ProfileRepoImpl] with injected remote data source
/// 🧼 Used by use cases to access user profile with caching and failure mapping
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
String _$profileRemoteDataSourceHash() =>
    r'fbad241ce5637c2af37265e8f872d405b1ddd94a'; ////
////
///
/// Copied from [profileRemoteDataSource].
@ProviderFor(profileRemoteDataSource)
final profileRemoteDataSourceProvider =
    AutoDisposeProvider<IProfileRemoteDataSource>.internal(
      profileRemoteDataSource,
      name: r'profileRemoteDataSourceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$profileRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProfileRemoteDataSourceRef =
    AutoDisposeProviderRef<IProfileRemoteDataSource>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
