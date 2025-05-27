// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routerHash() => r'a24c182aa434ab2073faca76c052f94085355d9b';

/// 🧭 [routerProvider] — GoRouter provider with dynamic auth-aware redirects
/// 🔐 Listens to Firebase auth state and automatically redirects:
///   - 🚪 to `/signin` if not authenticated
///   - 🧪 to `/verifyEmail` if email not verified
///   - 🧯 to `/firebaseError` on auth stream error
///   - ⏳ to `/splash` while loading
///   - ✅ to `/home` when authenticated and verified
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
