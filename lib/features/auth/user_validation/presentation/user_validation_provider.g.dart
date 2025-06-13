// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_validation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$emailVerificationNotifierHash() =>
    r'c096723cc39aab578bb3fce6ef799a912257d66c';

/// 🧩 [emailVerificationNotifierProvider] — async notifier that handles email verification polling
/// 🧼 Sends verification email and checks if email is verified via Firebase
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
