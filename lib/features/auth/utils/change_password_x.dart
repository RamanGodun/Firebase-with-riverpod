import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_riverpod/core/modules_shared/errors_handling/failures/extensions/to_ui_failure_x.dart';
import 'package:firebase_with_riverpod/core/modules_shared/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_riverpod/core/modules_shared/overlays/core/_context_x_for_overlays.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../change_password/presentation/change_password_provider.dart';
import '../change_password/presentation/reauth_page.dart';
import '../../../core/modules_shared/localization/generated/locale_keys.g.dart';
import '../../../core/modules_shared/navigation/core/routes_names.dart';
import '../../../core/modules_shared/errors_handling/failures/failure_entity.dart';

/// 🧩 [RefPasswordChangeListenerX] — declarative handler for ChangePassword lifecycle
extension RefPasswordChangeListenerX on WidgetRef {
  void listenToPasswordChange(BuildContext context) {
    final showSnackbar = context.showUserSnackbar;

    listen<AsyncValue<void>>(changePasswordProvider, (prev, next) async {
      next.whenOrNull(
        data: (_) {
          showSnackbar(message: LocaleKeys.reauth_password_updated.tr());
          if (context.mounted) {
            context.goTo(RoutesNames.reAuthentication);
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
            final result = await context.pushTo<String>(
              const ReAuthenticationPage(),
            );

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
}
