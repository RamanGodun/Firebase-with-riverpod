// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_layer_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$passwordRemoteDataSourceHash() =>
    r'45bde654f35d756198afa739a18f00b7a3caffb6';

/// 🧩 [passwordRemoteDataSourceProvider] — provides implementation of [IPasswordRemoteDataSource]
/// ✅ Low-level data access for password-related Firebase actions
///
/// Copied from [passwordRemoteDataSource].
@ProviderFor(passwordRemoteDataSource)
final passwordRemoteDataSourceProvider =
    AutoDisposeProvider<IPasswordRemoteDataSource>.internal(
      passwordRemoteDataSource,
      name: r'passwordRemoteDataSourceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$passwordRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PasswordRemoteDataSourceRef =
    AutoDisposeProviderRef<IPasswordRemoteDataSource>;
String _$passwordRepoHash() => r'6446de53a6a93c73e036841b609e1d1b5f80c260';

/// 🧩 [passwordRepoProvider] — provides implementation of [IPasswordRepo]
/// 🧼 Adds failure mapping on top of remote data source
/// ✅ Used by domain layer use cases
///
/// Copied from [passwordRepo].
@ProviderFor(passwordRepo)
final passwordRepoProvider = AutoDisposeProvider<IPasswordRepo>.internal(
  passwordRepo,
  name: r'passwordRepoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$passwordRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PasswordRepoRef = AutoDisposeProviderRef<IPasswordRepo>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
