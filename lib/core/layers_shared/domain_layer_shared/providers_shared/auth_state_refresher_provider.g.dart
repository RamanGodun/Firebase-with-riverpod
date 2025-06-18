// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state_refresher_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authStateRefreshStreamHash() =>
    r'5bcf2ebc5dfbfef338dd79a09a9fec20d8ca6984';

/// 🪝 [authStateRefreshStream] — Riverpod Provider exposing [AuthStateRefresher]
/// Internally binds to [authStateStreamProvider.stream]
/// ✅ Used by `refreshListenable` in GoRouter
///
/// Copied from [authStateRefreshStream].
@ProviderFor(authStateRefreshStream)
final authStateRefreshStreamProvider =
    AutoDisposeProvider<Raw<AuthStateRefresher>>.internal(
      authStateRefreshStream,
      name: r'authStateRefreshStreamProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$authStateRefreshStreamHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthStateRefreshStreamRef =
    AutoDisposeProviderRef<Raw<AuthStateRefresher>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
