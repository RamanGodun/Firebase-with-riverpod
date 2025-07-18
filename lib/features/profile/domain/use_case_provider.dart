import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/data_layer_providers.dart';
import 'use_case.dart';

part 'use_case_provider.g.dart';

/// 🧩 [getProfileUseCaseProvider] — provides [GetProfileUseCase]
/// 🧼 Injects repository dependency from data layer
//
@Riverpod(keepAlive: false)
GetProfileUseCase getProfileUseCase(Ref ref) {
  ///-----------------------------------------
  //
  final repo = ref.watch(profileRepoProvider);
  return GetProfileUseCase(repo);
  //
}
