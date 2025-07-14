import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_riverpod/core/base_modules/errors_handling/failures/extensions/to_ui_failure_x.dart';
import 'package:firebase_with_riverpod/core/base_modules/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_riverpod/core/base_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/base_modules/errors_handling/failures/failure_model.dart';
import '../../../core/base_modules/localization/generated/locale_keys.g.dart';
import '../../../core/base_modules/navigation/app_routes/app_routes.dart';
import '../../change_reset_password/presentation/reset_password/providers/reset_password_form_provider.dart';
import '../../change_reset_password/presentation/reset_password/providers/reset_password_provider.dart';

/// 🧩 [RefResetPasswordListenerX] — declarative handler for ResetPassword lifecycle

extension RefResetPasswordListenerX on WidgetRef {
  ///--------------------------------------------

  //
  void listenToResetPassword(BuildContext context) {
    final showSnackbar = context.showUserSnackbar;

    listen<AsyncValue<void>>(resetPasswordProvider, (prev, next) {
      next.whenOrNull(
        data: (_) {
          showSnackbar(message: LocaleKeys.reset_password_success.tr());
          if (context.mounted) {
            context.goTo(RoutesNames.signIn);
          }
        },
        error: (e, _) {
          final failure =
              e is Failure
                  ? e
                  : UnknownFailure(
                    message: 'Unexpected error during password reset',
                  );
          context.showError(failure.toUIEntity());
        },
      );
    });
  }

  /// Triggers password reset logic using current form state
  void submitResetPassword() {
    final form = read(resetPasswordFormProvider);
    read(resetPasswordProvider.notifier).resetPassword(email: form.email.value);
  }

  //
}
