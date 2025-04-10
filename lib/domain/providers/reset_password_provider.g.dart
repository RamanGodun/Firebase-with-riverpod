// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$resetPasswordHash() => r'3e9274b011986821202fc0b592863e686dae488f';

/// **Reset Password Provider**
///
/// A Riverpod provider responsible for handling the password reset feature.
///
/// - **Manages state** using `AsyncValue<void>`
/// - **Calls** [AuthRepository] to send a password reset email.
/// - **Ensures error safety** with `AsyncValue.guard()`
///
/// Usage:
/// ```dart
/// ref.read(resetPasswordProvider.notifier).resetPassword(email: userEmail);
/// ```
///
/// Copied from [ResetPassword].
@ProviderFor(ResetPassword)
final resetPasswordProvider =
    AutoDisposeAsyncNotifierProvider<ResetPassword, void>.internal(
      ResetPassword.new,
      name: r'resetPasswordProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$resetPasswordHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ResetPassword = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
