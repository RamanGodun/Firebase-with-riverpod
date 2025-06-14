// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profileHash() => r'dd91835137ad81009196d8708dca39b2ad05f9e2';

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

abstract class _$Profile extends BuildlessAutoDisposeAsyncNotifier<AppUser> {
  late final String uid;

  FutureOr<AppUser> build(String uid);
}

/// 👤 [profileProvider] — async notifier that fetches user profile
/// 🧼 Declarative-only approach, throws [Failure] and is handled in `.listenFailure(...)`
/// 🧼 Compatible with `.family` and avoids breaking [SafeAsyncState] limitations
///
/// Copied from [Profile].
@ProviderFor(Profile)
const profileProvider = ProfileFamily();

/// 👤 [profileProvider] — async notifier that fetches user profile
/// 🧼 Declarative-only approach, throws [Failure] and is handled in `.listenFailure(...)`
/// 🧼 Compatible with `.family` and avoids breaking [SafeAsyncState] limitations
///
/// Copied from [Profile].
class ProfileFamily extends Family<AsyncValue<AppUser>> {
  /// 👤 [profileProvider] — async notifier that fetches user profile
  /// 🧼 Declarative-only approach, throws [Failure] and is handled in `.listenFailure(...)`
  /// 🧼 Compatible with `.family` and avoids breaking [SafeAsyncState] limitations
  ///
  /// Copied from [Profile].
  const ProfileFamily();

  /// 👤 [profileProvider] — async notifier that fetches user profile
  /// 🧼 Declarative-only approach, throws [Failure] and is handled in `.listenFailure(...)`
  /// 🧼 Compatible with `.family` and avoids breaking [SafeAsyncState] limitations
  ///
  /// Copied from [Profile].
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

/// 👤 [profileProvider] — async notifier that fetches user profile
/// 🧼 Declarative-only approach, throws [Failure] and is handled in `.listenFailure(...)`
/// 🧼 Compatible with `.family` and avoids breaking [SafeAsyncState] limitations
///
/// Copied from [Profile].
class ProfileProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Profile, AppUser> {
  /// 👤 [profileProvider] — async notifier that fetches user profile
  /// 🧼 Declarative-only approach, throws [Failure] and is handled in `.listenFailure(...)`
  /// 🧼 Compatible with `.family` and avoids breaking [SafeAsyncState] limitations
  ///
  /// Copied from [Profile].
  ProfileProvider(String uid)
    : this._internal(
        () => Profile()..uid = uid,
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
  FutureOr<AppUser> runNotifierBuild(covariant Profile notifier) {
    return notifier.build(uid);
  }

  @override
  Override overrideWith(Profile Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProfileProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<Profile, AppUser> createElement() {
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
mixin ProfileRef on AutoDisposeAsyncNotifierProviderRef<AppUser> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _ProfileProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Profile, AppUser>
    with ProfileRef {
  _ProfileProviderElement(super.provider);

  @override
  String get uid => (origin as ProfileProvider).uid;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
