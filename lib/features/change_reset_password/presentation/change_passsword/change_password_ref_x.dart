part of 'change_password_page.dart';

/// 🛡️ [PasswordChangeRefX] - Providing all side-effect handlers related to the Change Password flow.
/// Encapsulates success, error, and retry handling.
///   - ✅ On success: shows success snackbar and navigates home.
///   - ❌ On failure: shows localized error.
///   - 🔄 On "requires-recent-login" error: triggers reauthentication flow and retries on success.

extension PasswordChangeRefX on WidgetRef {
  ///---------------------------------------------

  /// 👂 Listens to [changePasswordProvider] state changes and triggers declarative side-effects.
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
