import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_riverpod/core/base_modules/errors_handling/failures/extensions/to_ui_failure_x.dart';
import 'package:firebase_with_riverpod/core/base_modules/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_riverpod/core/base_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:firebase_with_riverpod/features/auth/sign_in/presentation/signin_page.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/base_modules/navigation/app_routes/app_routes.dart';
import '../../change_reset_password/presentation/change_passsword/providers/change_password_form_provider.dart';
import '../../change_reset_password/presentation/change_passsword/providers/change_password_provider.dart';
import '../../../core/base_modules/localization/generated/locale_keys.g.dart';
import '../../../core/base_modules/errors_handling/failures/failure_model.dart';

/// 🧩 [RefPasswordChangeListenerX] — declarative handler for ChangePassword lifecycle

extension RefPasswordChangeListenerX on WidgetRef {
  ///---------------------------------------------

  /// 🧠 Handles success and error outcomes declaratively
  /// 🔁 Supports retry flow via reauthentication
  void listenToPasswordChange(BuildContext context) {
    final showSnackbar = context.showUserSnackbar;

    listen<AsyncValue<void>>(changePasswordProvider, (prev, next) async {
      next.whenOrNull(
        data: (_) {
          showSnackbar(message: LocaleKeys.reauth_password_updated.tr());
          if (context.mounted) {
            context.goTo(RoutesNames.signIn);
          }
        },
        error: (e, st) async {
          final failure =
              e is Failure
                  ? e
                  : UnknownFailure(
                    message: 'Unexpected error during password change',
                  );

          if (failure.code == 'requires-recent-login') {
            final result = await context.pushTo<String>(const SignInPage());

            if (result == 'success') {
              showSnackbar(message: LocaleKeys.change_password_success.tr());
              await read(changePasswordProvider.notifier).retryAfterReauth();
            }
          } else {
            context.showError(failure.toUIEntity());
          }
        },
      );
    });
  }

  /// 📤 Submits the password change request
  Future<void> submitChangePassword() async {
    final form = watch(changePasswordFormProvider);
    if (!form.isValid) return;

    final notifier = read(changePasswordProvider.notifier);
    await notifier.changePassword(form.password.value);
  }

  //
}
