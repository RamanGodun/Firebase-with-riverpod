import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/shared_domain/entities/app_user.dart';
import '../domain_and_data/_profile_use_case.dart';

part 'profile_provider.g.dart';

/// 🧩 [profileProvider] — state manager, that delegates logic to use case.
//----------------------------------------------------------------//
@riverpod
Future<AppUser> profile(ref, String uid) async {
  final useCase = ref.watch(getProfileUseCaseProvider(uid));
  return useCase.call(uid);
}
