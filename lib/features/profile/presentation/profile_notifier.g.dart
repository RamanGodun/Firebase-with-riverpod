// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profileNotifierHash() => r'0c6920274dcf7388e4c3bf1839d9ca7ad5c51af4';

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

abstract class _$ProfileNotifier
    extends BuildlessAutoDisposeAsyncNotifier<AppUser> {
  late final String uid;

  FutureOr<AppUser> build(String uid);
}

/// 🧩 [profileProvider] — state manager, that delegates logic to use case.
///
/// Copied from [ProfileNotifier].
@ProviderFor(ProfileNotifier)
const profileNotifierProvider = ProfileNotifierFamily();

/// 🧩 [profileProvider] — state manager, that delegates logic to use case.
///
/// Copied from [ProfileNotifier].
class ProfileNotifierFamily extends Family<AsyncValue<AppUser>> {
  /// 🧩 [profileProvider] — state manager, that delegates logic to use case.
  ///
  /// Copied from [ProfileNotifier].
  const ProfileNotifierFamily();

  /// 🧩 [profileProvider] — state manager, that delegates logic to use case.
  ///
  /// Copied from [ProfileNotifier].
  ProfileNotifierProvider call(String uid) {
    return ProfileNotifierProvider(uid);
  }

  @override
  ProfileNotifierProvider getProviderOverride(
    covariant ProfileNotifierProvider provider,
  ) {
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
  String? get name => r'profileNotifierProvider';
}

/// 🧩 [profileProvider] — state manager, that delegates logic to use case.
///
/// Copied from [ProfileNotifier].
class ProfileNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ProfileNotifier, AppUser> {
  /// 🧩 [profileProvider] — state manager, that delegates logic to use case.
  ///
  /// Copied from [ProfileNotifier].
  ProfileNotifierProvider(String uid)
    : this._internal(
        () => ProfileNotifier()..uid = uid,
        from: profileNotifierProvider,
        name: r'profileNotifierProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$profileNotifierHash,
        dependencies: ProfileNotifierFamily._dependencies,
        allTransitiveDependencies:
            ProfileNotifierFamily._allTransitiveDependencies,
        uid: uid,
      );

  ProfileNotifierProvider._internal(
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
  FutureOr<AppUser> runNotifierBuild(covariant ProfileNotifier notifier) {
    return notifier.build(uid);
  }

  @override
  Override overrideWith(ProfileNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProfileNotifierProvider._internal(
        () => create()..uid = uid,
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
  AutoDisposeAsyncNotifierProviderElement<ProfileNotifier, AppUser>
  createElement() {
    return _ProfileNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProfileNotifierProvider && other.uid == uid;
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
mixin ProfileNotifierRef on AutoDisposeAsyncNotifierProviderRef<AppUser> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _ProfileNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProfileNotifier, AppUser>
    with ProfileNotifierRef {
  _ProfileNotifierProviderElement(super.provider);

  @override
  String get uid => (origin as ProfileNotifierProvider).uid;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
