import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/failures/extensions/to_ui_failure_x.dart';
import 'package:firebase_with_riverpod/core/shared_modules/navigation/utils/context_x.dart';
import 'package:firebase_with_riverpod/core/shared_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:firebase_with_riverpod/features/auth/presentation/reset_password/reset_password_provider.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared_modules/errors_handling/failures/failure_entity.dart';
import '../../shared_modules/localization/generated/locale_keys.g.dart';
import '../../shared_modules/navigation/routes_names.dart';

/// 🧩 [RefResetPasswordListenerX] — declarative handler for ResetPassword lifecycle
extension RefResetPasswordListenerX on WidgetRef {
  void listenToResetPassword(BuildContext context) {
    final showSnackbar = context.showUserSnackbar;

    listen<AsyncValue<void>>(resetPasswordProvider, (prev, next) {
      next.whenOrNull(
        data: (_) {
          showSnackbar(message: LocaleKeys.reset_password_success.tr());
          if (context.mounted) {
            context.goTo(RoutesNames.signin);
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
}
