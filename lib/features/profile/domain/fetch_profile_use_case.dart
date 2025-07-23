import 'package:firebase_with_riverpod/core/base_modules/errors_handling/either/either_extensions/either_getters_x.dart';
import 'package:firebase_with_riverpod/core/base_modules/errors_handling/utils/observers/loggers/failure_logger_x.dart';
import '../../../core/utils_shared/type_definitions.dart';
import '../../../core/shared_domain_layer/entities/_user_entity.dart';
import 'repo_contract.dart';

/// 🧩 [FetchProfileUseCase] — Encapsulates domain logic of
//     loading profile (with "fetch-or-create" user logic)
//
final class FetchProfileUseCase {
  ///-----------------------------------------------
  //
  final IProfileRepo _repo;
  const FetchProfileUseCase(this._repo);

  /// 🚀 Loads user profile by UID; creates if missing, then reloads.
  ResultFuture<UserEntity> call(String uid) async {
    // 1️⃣ Try to load profile
    final result = await _repo.getProfile(uid: uid);
    if (result.isRight) return result;

    // 2️⃣ If not found, log and create profile
    result.leftOrNull?.log();
    await _repo.createUserProfile(uid);

    // 3️⃣ Try again after creation
    return _repo.getProfile(uid: uid);
  }
}
