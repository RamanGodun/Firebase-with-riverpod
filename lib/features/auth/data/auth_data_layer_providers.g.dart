// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_data_layer_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRemoteDataSourceHash() =>
    r'fc4c60e2ce5358d4271b9b015b31dbbe61e6bb3c';

/// 🔌 [authRemoteDataSourceProvider] — provides instance of [AuthRemoteDataSourceImpl]
/// 🧼 Dependency injection for Firebase Auth access
///
/// Copied from [authRemoteDataSource].
@ProviderFor(authRemoteDataSource)
final authRemoteDataSourceProvider =
    AutoDisposeProvider<IAuthRemoteDataSource>.internal(
      authRemoteDataSource,
      name: r'authRemoteDataSourceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$authRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRemoteDataSourceRef = AutoDisposeProviderRef<IAuthRemoteDataSource>;
String _$signInRepoHash() => r'cde27930b72ccf393d6f92d9eb6b316ddb2275de'; ////
////
/// 🧩 [signInRepoProvider] — provides instance of [SignInRepoImpl], injects [IAuthRemoteDataSource] from [authRemoteDataSourceProvider]
///
/// Copied from [signInRepo].
@ProviderFor(signInRepo)
final signInRepoProvider = AutoDisposeProvider<ISignInRepo>.internal(
  signInRepo,
  name: r'signInRepoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$signInRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SignInRepoRef = AutoDisposeProviderRef<ISignInRepo>;
String _$signOutRepoHash() => r'cf896c3f1e1922465c8ed985225ec9921f6c0db4'; ////
////
/// 🧩 [signOutRepoProvider] — provides instance of [SignOutRepoImpl], injects [IAuthRemoteDataSource]
///
/// Copied from [signOutRepo].
@ProviderFor(signOutRepo)
final signOutRepoProvider = AutoDisposeProvider<ISignOutRepo>.internal(
  signOutRepo,
  name: r'signOutRepoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$signOutRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SignOutRepoRef = AutoDisposeProviderRef<ISignOutRepo>;
String _$signUpRepoHash() => r'ff23eb0867617380a347c03b8eacc2c35de190f3'; ////
////
/// 🧩 [signUpRepoProvider] — provides instance of [SignUpRepoImpl], injects [IAuthRemoteDataSource]
///
/// Copied from [signUpRepo].
@ProviderFor(signUpRepo)
final signUpRepoProvider = AutoDisposeProvider<ISignUpRepo>.internal(
  signUpRepo,
  name: r'signUpRepoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$signUpRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SignUpRepoRef = AutoDisposeProviderRef<ISignUpRepo>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
