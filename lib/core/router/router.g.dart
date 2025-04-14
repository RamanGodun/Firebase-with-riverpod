// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routerHash() => r'aa7684c33b0781173786ea6f738e14792d6a7bc1';

/// 🧭 [router] — GoRouter provider with dynamic auth-aware redirects
/// Listens to Firebase auth state and redirects:
///   • `/signin` if unauthenticated
///   • `/verifyEmail` if email is not verified
///   • `/firebaseError` on auth stream error
///   • `/splash` while loading
///   • Otherwise → `/home` or matched route
///
/// Copied from [router].
@ProviderFor(router)
final routerProvider = AutoDisposeProvider<GoRouter>.internal(
  router,
  name: r'routerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$routerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RouterRef = AutoDisposeProviderRef<GoRouter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
