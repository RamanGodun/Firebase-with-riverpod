// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_verification_repo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$emailVerificationRepoHash() =>
    r'4bd3fd905bd8457f185d114f98e7ced33e15220f';

/// 🧩 [emailVerificationRepoProvider] — provides instance of [IUserValidationRepoImpl]
/// 🧼 Dependency injection for email verification functionality
///
/// Copied from [emailVerificationRepo].
@ProviderFor(emailVerificationRepo)
final emailVerificationRepoProvider =
    AutoDisposeProvider<IUserValidationRepo>.internal(
      emailVerificationRepo,
      name: r'emailVerificationRepoProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$emailVerificationRepoHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EmailVerificationRepoRef = AutoDisposeProviderRef<IUserValidationRepo>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
