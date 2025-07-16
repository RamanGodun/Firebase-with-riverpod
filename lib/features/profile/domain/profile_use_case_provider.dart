import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/profile_repo_provider.dart';
import 'profile_use_case.dart';

part 'profile_use_case_provider.g.dart';

/// 📦 [GetProfileUseCase] — encapsulates get profile process
/// 🧼 Handles user authentication using [IProfileRepo]
//
@Riverpod(keepAlive: false)
GetProfileUseCase getProfileUseCase(Ref ref) {
  ///-----------------------------------------
  //
  final repo = ref.watch(profileRepoProvider);
  return GetProfileUseCase(repo);
  //
}
