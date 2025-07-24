import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/providers/data_layer_providers.dart';
import '../email_verification_use_case.dart';

part 'use_case_provider.g.dart';

/// 🧩 [emailVerificationUseCaseProvider] — provides [EmailVerificationUseCase]
//
@riverpod
EmailVerificationUseCase emailVerificationUseCase(Ref ref) {
  ///---------------------------------------------------
  //
  final repo = ref.watch(emailVerificationRepoProvider);
  return EmailVerificationUseCase(repo);
}
