// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$signinHash() => r'9fd884ed49f646083f32146cce31834df0d79b61';

/// **Signin Provider**
///
/// A Riverpod provider responsible for handling user sign-in.
///
/// - **Manages authentication state** using `AsyncValue<void>`.
/// - **Calls** [AuthRepository] to perform user sign-in.
/// - **Ensures error safety** with `AsyncValue.guard()`.
///
/// Usage:
/// ```dart
/// ref.read(signinProvider.notifier).signin(email: userEmail, password: userPassword);
/// ```
///
/// Copied from [Signin].
@ProviderFor(Signin)
final signinProvider = AutoDisposeAsyncNotifierProvider<Signin, void>.internal(
  Signin.new,
  name: r'signinProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$signinHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Signin = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
