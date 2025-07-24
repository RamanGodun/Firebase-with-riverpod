import 'package:firebase_with_riverpod/core/base_modules/localization/generated/locale_keys.g.dart'
    show LocaleKeys;
import 'package:firebase_with_riverpod/core/base_modules/navigation/extensions/navigation_x_on_context.dart';
import 'package:firebase_with_riverpod/core/base_modules/overlays/overlays_dispatcher/overlay_dispatcher_provider.dart';
import 'package:firebase_with_riverpod/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useFocusNode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show HookConsumerWidget;
import '../../../../core/shared_presentation_layer/widgets_shared/buttons/text_button.dart';
import '../../../../core/base_modules/localization/widgets/text_widget.dart';
import '../../../../core/base_modules/navigation/app_routes/app_routes.dart';
import '../../../../core/base_modules/theme/ui_constants/_app_constants.dart';
import '../../../../core/utils_shared/extensions/context_extensions/_context_extensions.dart';
import '../../../../core/shared_presentation_layer/widgets_shared/buttons/filled_button.dart';
import '../../../../core/base_modules/form_fields/input_validation/validation_enums.dart';
import '../../../../core/base_modules/form_fields/widgets/_fields_factory.dart';
import 'providers/reset_password_form_provider.dart';
import 'providers/reset_password_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_riverpod/core/base_modules/errors_handling/failures/extensions/to_ui_failure_x.dart';
import 'package:firebase_with_riverpod/core/base_modules/overlays/core/_context_x_for_overlays.dart';
import '../../../../core/base_modules/errors_handling/failures/failure_entity.dart';
import '../../../../core/base_modules/localization/generated/locale_keys.g.dart';

part 'widgets_for_reset_password_page.dart';

/// 🔐 [ResetPasswordPage] — screen that allows user to request password reset
/// 📩 Sends reset link to user's email using [ResetPasswordProvider]
//
final class ResetPasswordPage extends ConsumerWidget {
  ///------------------------------------------
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    // 👂 Declarative listener for success/failure
    ref.listenToResetPassword(context);

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,
          child: ListView(
            shrinkWrap: true,
            children: const [
              //
              _ResetPasswordHeader(),

              _ResetPasswordEmailInputField(),
              SizedBox(height: AppSpacing.huge),

              _ResetPasswordSubmitButton(),
              SizedBox(height: AppSpacing.xxxs),

              _ResetPasswordFooter(),
            ],
          ).withPaddingHorizontal(AppSpacing.l),
        ),
      ),
    );
  }
}

////

////

/// 🛡️ [ResetPasswordRefX] — extension for WidgetRef to handle Reset Password side-effects.
/// Handles submission and listens for result feedback (success/error).
//
extension ResetPasswordRefX on WidgetRef {
  //
  /// Encapsulates success and error handling for the reset password process.
  ///   - ✅ On success: shows success snackbar and navigates to Sign In page.
  ///   - ❌ On failure: shows localized error.
  void listenToResetPassword(BuildContext context) {
    final showSnackbar = context.showUserSnackbar;

    listen<AsyncValue<void>>(resetPasswordProvider, (prev, next) {
      next.whenOrNull(
        // ✅ On success
        data: (_) {
          showSnackbar(message: LocaleKeys.reset_password_success.tr());
          context.goIfMounted(RoutesNames.signIn);
        },
        // ❌ On error
        error: (error, _) => context.showError((error as Failure).toUIEntity()),
      );
    });
  }

  ////

  /// 📤 Submits the password reset request using the current form state.
  void submitResetPassword() {
    final form = read(resetPasswordFormProvider);
    read(resetPasswordProvider.notifier).resetPassword(email: form.email.value);
  }

  //
}
