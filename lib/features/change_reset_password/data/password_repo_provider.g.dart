// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_repo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$passwordRepoHash() => r'53d5b94248b9c9198133a54e8638222a2fc7ff62';

/// 🧩 [passwordRepoProvider] — provides instance of [PasswordRepoImpl]
/// 🧼 Dependency injection for all password-related functionality
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
