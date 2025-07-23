import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/providers/data_layer_providers.dart';
import '../fetch_profile_use_case.dart';

part 'use_case_provider.g.dart';

/// 🧩 [fetchProfileUseCaseProvider] — provides [FetchProfileUseCase]
/// 🧼 Injects repository dependency from data layer
//
@Riverpod(keepAlive: false)
FetchProfileUseCase fetchProfileUseCase(Ref ref) {
  ///-----------------------------------------
  //
  final repo = ref.watch(profileRepoProvider);
  return FetchProfileUseCase(repo);
  //
}
