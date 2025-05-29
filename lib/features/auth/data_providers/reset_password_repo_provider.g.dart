// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_repo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$resetPasswordRepoHash() => r'9fa71202be9816f174696fe798011577060c12f8';

/// 🧩 [resetPasswordRepoProvider] — provides instance of [ResetPasswordRepoImpl]
/// 🧼 Dependency injection for password reset functionality
///
/// Copied from [resetPasswordRepo].
@ProviderFor(resetPasswordRepo)
final resetPasswordRepoProvider =
    AutoDisposeProvider<IResetPasswordRepo>.internal(
      resetPasswordRepo,
      name: r'resetPasswordRepoProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$resetPasswordRepoHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ResetPasswordRepoRef = AutoDisposeProviderRef<IResetPasswordRepo>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
