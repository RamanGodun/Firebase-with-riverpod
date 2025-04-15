// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$formStateNotifierHash() => r'231686dd74ac53e390dcbd4ea183aac32c8b7955';

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

abstract class _$FormStateNotifier
    extends BuildlessAutoDisposeNotifier<FormStateModel> {
  late final List<FormFieldType> activeFields;

  FormStateModel build(List<FormFieldType> activeFields);
}

/// See also [FormStateNotifier].
@ProviderFor(FormStateNotifier)
const formStateNotifierProvider = FormStateNotifierFamily();

/// See also [FormStateNotifier].
class FormStateNotifierFamily extends Family<FormStateModel> {
  /// See also [FormStateNotifier].
  const FormStateNotifierFamily();

  /// See also [FormStateNotifier].
  FormStateNotifierProvider call(List<FormFieldType> activeFields) {
    return FormStateNotifierProvider(activeFields);
  }

  @override
  FormStateNotifierProvider getProviderOverride(
    covariant FormStateNotifierProvider provider,
  ) {
    return call(provider.activeFields);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'formStateNotifierProvider';
}

/// See also [FormStateNotifier].
class FormStateNotifierProvider
    extends AutoDisposeNotifierProviderImpl<FormStateNotifier, FormStateModel> {
  /// See also [FormStateNotifier].
  FormStateNotifierProvider(List<FormFieldType> activeFields)
    : this._internal(
        () => FormStateNotifier()..activeFields = activeFields,
        from: formStateNotifierProvider,
        name: r'formStateNotifierProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$formStateNotifierHash,
        dependencies: FormStateNotifierFamily._dependencies,
        allTransitiveDependencies:
            FormStateNotifierFamily._allTransitiveDependencies,
        activeFields: activeFields,
      );

  FormStateNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.activeFields,
  }) : super.internal();

  final List<FormFieldType> activeFields;

  @override
  FormStateModel runNotifierBuild(covariant FormStateNotifier notifier) {
    return notifier.build(activeFields);
  }

  @override
  Override overrideWith(FormStateNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: FormStateNotifierProvider._internal(
        () => create()..activeFields = activeFields,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        activeFields: activeFields,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<FormStateNotifier, FormStateModel>
  createElement() {
    return _FormStateNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FormStateNotifierProvider &&
        other.activeFields == activeFields;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, activeFields.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FormStateNotifierRef on AutoDisposeNotifierProviderRef<FormStateModel> {
  /// The parameter `activeFields` of this provider.
  List<FormFieldType> get activeFields;
}

class _FormStateNotifierProviderElement
    extends
        AutoDisposeNotifierProviderElement<FormStateNotifier, FormStateModel>
    with FormStateNotifierRef {
  _FormStateNotifierProviderElement(super.provider);

  @override
  List<FormFieldType> get activeFields =>
      (origin as FormStateNotifierProvider).activeFields;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
