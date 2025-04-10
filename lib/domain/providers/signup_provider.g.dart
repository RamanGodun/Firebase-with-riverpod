// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$signupHash() => r'45b357680a00daaf098fb422fa914128bb895887';

/// **Signup Provider**
///
/// A Riverpod provider that handles user registration.
/// - Manages sign-up requests and state.
/// - Ensures **safe state updates** by using `_key` to avoid race conditions.
/// - Calls [AuthRepository] for authentication.
///
/// Usage:
/// ```dart
/// ref.read(signupProvider.notifier).signup(
///   name: userName,
///   email: userEmail,
///   password: userPassword,
/// );
/// ```
///
/// Copied from [Signup].
@ProviderFor(Signup)
final signupProvider = AutoDisposeAsyncNotifierProvider<Signup, void>.internal(
  Signup.new,
  name: r'signupProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$signupHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Signup = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
