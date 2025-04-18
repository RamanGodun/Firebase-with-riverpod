// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profileHash() => r'063fe7495732d3eef90810c0405500a0b7037177';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// 🧩 [profileProvider] — async provider, that returns user profile
/// 🧼 Incapsulates logic of getting user's data from [ProfileRepository]
///
/// Copied from [profile].
@ProviderFor(profile)
const profileProvider = ProfileFamily();

/// 🧩 [profileProvider] — async provider, that returns user profile
/// 🧼 Incapsulates logic of getting user's data from [ProfileRepository]
///
/// Copied from [profile].
class ProfileFamily extends Family<AsyncValue<AppUser>> {
  /// 🧩 [profileProvider] — async provider, that returns user profile
  /// 🧼 Incapsulates logic of getting user's data from [ProfileRepository]
  ///
  /// Copied from [profile].
  const ProfileFamily();

  /// 🧩 [profileProvider] — async provider, that returns user profile
  /// 🧼 Incapsulates logic of getting user's data from [ProfileRepository]
  ///
  /// Copied from [profile].
  ProfileProvider call(String uid) {
    return ProfileProvider(uid);
  }

  @override
  ProfileProvider getProviderOverride(covariant ProfileProvider provider) {
    return call(provider.uid);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'profileProvider';
}

/// 🧩 [profileProvider] — async provider, that returns user profile
/// 🧼 Incapsulates logic of getting user's data from [ProfileRepository]
///
/// Copied from [profile].
class ProfileProvider extends AutoDisposeFutureProvider<AppUser> {
  /// 🧩 [profileProvider] — async provider, that returns user profile
  /// 🧼 Incapsulates logic of getting user's data from [ProfileRepository]
  ///
  /// Copied from [profile].
  ProfileProvider(String uid)
    : this._internal(
        (ref) => profile(ref as ProfileRef, uid),
        from: profileProvider,
        name: r'profileProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$profileHash,
        dependencies: ProfileFamily._dependencies,
        allTransitiveDependencies: ProfileFamily._allTransitiveDependencies,
        uid: uid,
      );

  ProfileProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    FutureOr<AppUser> Function(ProfileRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProfileProvider._internal(
        (ref) => create(ref as ProfileRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<AppUser> createElement() {
    return _ProfileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProfileProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProfileRef on AutoDisposeFutureProviderRef<AppUser> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _ProfileProviderElement extends AutoDisposeFutureProviderElement<AppUser>
    with ProfileRef {
  _ProfileProviderElement(super.provider);

  @override
  String get uid => (origin as ProfileProvider).uid;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
