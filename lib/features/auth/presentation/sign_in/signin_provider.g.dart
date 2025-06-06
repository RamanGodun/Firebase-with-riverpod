// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$signinHash() => r'30e71b7ed916d139be0b103bd86858f7aff0f957';

/// 🧩 [signinProvider] — async notifier that handles user sign-in
/// 🧼 Uses [SafeAsyncState] to prevent post-dispose state updates
/// 🧼 Wraps logic in [AsyncValue.guard] for robust error handling
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
