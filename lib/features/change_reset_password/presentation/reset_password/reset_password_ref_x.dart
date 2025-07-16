part of 'reset_password_page.dart';

/// 🛡️ [ResetPasswordRefX] — Provides all side-effect handlers related to the Reset Password flow.
/// Encapsulates success and error handling for the reset password process.
///   - ✅ On success: shows success snackbar and navigates to Sign In page.
///   - ❌ On failure: shows localized error.
//
extension ResetPasswordRefX on WidgetRef {
  //
  /// 👂 Listens to [resetPasswordProvider] state changes and triggers declarative side-effects.
  void listenToResetPassword(BuildContext context) {
    final showSnackbar = context.showUserSnackbar;

    listen<AsyncValue<void>>(resetPasswordProvider, (prev, next) {
      next.whenOrNull(
        // ✅ On success
        data: (_) {
          showSnackbar(message: LocaleKeys.reset_password_success.tr());
          if (context.mounted) {
            context.goTo(RoutesNames.signIn);
          }
        },
        // ❌ On error
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

  /// 📤 Submits the password reset request using the current form state.
  void submitResetPassword() {
    final form = read(resetPasswordFormProvider);
    read(resetPasswordProvider.notifier).resetPassword(email: form.email.value);
  }

  //
}
