import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_riverpod/core/base_modules/errors_handling/failures/extensions/to_ui_failure_x.dart';
import 'package:firebase_with_riverpod/core/base_modules/localization/generated/locale_keys.g.dart';
import 'package:firebase_with_riverpod/core/base_modules/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_riverpod/core/base_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:firebase_with_riverpod/core/base_modules/overlays/overlays_dispatcher/overlay_dispatcher_provider.dart';
import 'package:firebase_with_riverpod/core/utils_shared/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_riverpod/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show HookConsumerWidget;
import '../../../../core/base_modules/errors_handling/failures/failure_entity.dart';
import '../../../../core/base_modules/navigation/app_routes/app_routes.dart';
import '../../../../core/shared_presentation_layer/widgets_shared/buttons/filled_button.dart';
import '../../../auth/presentation/sign_in/sign_in_page.dart';
import '../../../../core/base_modules/form_fields/input_validation/validation_enums.dart';
import '../../../../core/base_modules/form_fields/utils/use_auth_focus_nodes.dart';
import '../../../../core/base_modules/localization/widgets/text_widget.dart';
import '../../../../core/base_modules/theme/ui_constants/_app_constants.dart';
import '../../../../core/base_modules/form_fields/widgets/_fields_factory.dart';
import '../../../../core/base_modules/form_fields/widgets/password_visibility_icon.dart';
import 'providers/change_password_form_provider.dart';
import 'providers/change_password_provider.dart';

part 'widgets_for_change_password.dart';

/// 🔐 [ChangePasswordPage] — Screen that allows the user to update their password.
//
final class ChangePasswordPage extends HookConsumerWidget {
  ///-------------------------------------------
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    // 🔁 Declarative side-effect for ChangePassword
    ref.listenToPasswordChange(context);

    final focus = useChangePasswordFocusNodes();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,
          child: FocusTraversalGroup(
            child: ListView(
              shrinkWrap: true,
              children: [
                //
                const _ChangePasswordInfo(),
                _PasswordField(focus: focus),
                _ConfirmPasswordField(focus: focus),
                const _ChangePasswordSubmitButton(),
                //
              ],
            ).withPaddingHorizontal(AppSpacing.l),
          ),
        ),
      ),
    );
  }

  //
}

////

////

/// 🛡️ [PasswordChangeRefX] — handles side-effects for Change Password flow.
/// Handles success, error, and reauth-required cases.
//
extension PasswordChangeRefX on WidgetRef {
  ///---------------------------------------------
  //
  /// Encapsulates success, error, and retry handling.
  ///   - ✅ On success: shows success snackbar and navigates home.
  ///   - ❌ On failure: shows localized error.
  ///   - 🔄 On "requires-recent-login" error: triggers reauthentication flow and retries on success.
  void listenToPasswordChange(BuildContext context) {
    final showSnackbar = context.showUserSnackbar;

    listen<AsyncValue<void>>(changePasswordProvider, (prev, next) async {
      next.whenOrNull(
        // ✅ On success
        data: (_) async {
          showSnackbar(message: LocaleKeys.reauth_password_updated.tr());

          if (context.mounted) {
            context.goTo(RoutesNames.home);
          }
        },

        /// ❌ On error
        error: (e, st) async {
          final failure =
              e is Failure
                  ? e
                  : UnknownFailure(
                    message: 'Unexpected error during password change',
                  );

          /// 🔄 Special: requires recent login
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
        //
      );
    });
  }

  ////

  /// 📤 Submits the password change request (when the form is valid)
  Future<void> submitChangePassword() async {
    final form = watch(changePasswordFormProvider);
    if (!form.isValid) return;

    final notifier = read(changePasswordProvider.notifier);
    await notifier.changePassword(form.password.value);
  }

  //
}
