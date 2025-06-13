import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/shared_modules/errors_handling/utils/observers/loggers/errors_log_util.dart';
import '../../utils/auth_user_utils.dart';
import '../domain/change_password_repo_contract.dart';

part 'change_password_repo_provider.g.dart';

/// 🧩 [changePasswordRepoProvider] — provides instance of [ChangePasswordRepoImpl]
/// 🧼 Dependency injection for changing password functionality
@riverpod
IChangePasswordRepo changePasswordRepo(Ref ref) => ChangePasswordRepoImpl();

///

///

/// 🧩 [ChangePasswordRepoImpl] — concrete implementation of [IChangePasswordRepo]
/// 🧼 Uses FirebaseAuth to update password for the current user

final class ChangePasswordRepoImpl implements IChangePasswordRepo {
  ///-------------------------------------------------------------

  @override
  Future<void> changePassword(String newPassword) async {
    //
    try {
      final user = AuthUserUtils.currentUserOrThrow;
      await user.updatePassword(newPassword);
    } catch (e, st) {
      ErrorsLogger.log(e, st);
      rethrow;
    }
  }

  //
}
