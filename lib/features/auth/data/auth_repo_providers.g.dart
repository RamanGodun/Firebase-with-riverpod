// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repo_providers.dart';

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
String _$signInRepoHash() => r'7c2d4699c935c1e25da93d34448f9a2791e8fcb0'; ////
////
/// 🧩 [signInRepoProvider] — provides instance of [SignInRepoImpl]
/// 🧼 Dependency injection for user sign-in logic
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
String _$signOutRepoHash() => r'45771d917f241ee26457e89625a6512624219064'; ////
////
/// 🧩 [signOutRepoProvider] — provides instance of [SignOutRepoImpl]
/// 🧼 Dependency injection for sign-out operation
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
String _$signUpRepoHash() => r'd00543e8f6083a09036e8afc731d69ffb74844b9'; ////
////
/// 🧩 [signUpRepoProvider] — provides instance of [SignUpRepoImpl]
/// 🧼 Dependency injection for sign-up logic
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
