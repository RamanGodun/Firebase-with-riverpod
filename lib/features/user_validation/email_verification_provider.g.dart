// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_verification_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$emailVerificationNotifierHash() =>
    r'd0b238728e9542bb6b27e74eadbee3e3e51805d8';

/// 🧩 [emailVerificationNotifierProvider] — async notifier that handles email verification
/// 🧼 Sends verification email and polls every 5s to check if user verified email
///
/// Copied from [EmailVerificationNotifier].
@ProviderFor(EmailVerificationNotifier)
final emailVerificationNotifierProvider =
    AutoDisposeAsyncNotifierProvider<EmailVerificationNotifier, void>.internal(
      EmailVerificationNotifier.new,
      name: r'emailVerificationNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$emailVerificationNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$EmailVerificationNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
