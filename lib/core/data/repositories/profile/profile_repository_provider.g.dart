// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profileRepositoryHash() => r'2a010f6ed5ff032b91d9ec4959a43cafd642cf2b';

/// **Profile Repository Provider**
///
/// A Riverpod provider that exposes an instance of [ProfileRepository].
///
/// - **Usage:** Provides access to user profile operations such as fetching user details.
/// - **Scope:** Singleton instance managed by Riverpod.
///
/// Copied from [profileRepository].
@ProviderFor(profileRepository)
final profileRepositoryProvider =
    AutoDisposeProvider<ProfileRepository>.internal(
  profileRepository,
  name: r'profileRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$profileRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProfileRepositoryRef = AutoDisposeProviderRef<ProfileRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
