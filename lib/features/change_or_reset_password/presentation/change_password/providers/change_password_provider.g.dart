// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$changePasswordHash() => r'2cc8b215659e0b4c1437a521a0cdf9f6210b9932';

/// 🧩 [changePasswordProvider] — async notifier that handles password update
/// 🧼 Uses [SafeAsyncState] to prevent post-dispose state updates
/// 🧼 Wraps logic in [AsyncValue.guard] for robust error handling
///
/// Copied from [ChangePassword].
@ProviderFor(ChangePassword)
final changePasswordProvider =
    AutoDisposeAsyncNotifierProvider<ChangePassword, void>.internal(
      ChangePassword.new,
      name: r'changePasswordProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$changePasswordHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ChangePassword = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
