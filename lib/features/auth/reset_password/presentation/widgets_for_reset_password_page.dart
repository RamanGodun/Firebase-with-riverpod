part of 'reset_password_page.dart';

/// ℹ️ [_ResetPasswordHeader] — header section with logo & instructions

class _ResetPasswordHeader extends StatelessWidget {
  //-----------------------------------------------
  const _ResetPasswordHeader();

  @override
  Widget build(BuildContext context) {
    //
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: AppSpacing.huge),
        SizedBox(height: AppSpacing.huge),
        FlutterLogo(size: AppSpacing.huge),
        SizedBox(height: AppSpacing.xxxm),
        TextWidget(LocaleKeys.reset_password_header, TextType.headlineSmall),
        TextWidget(LocaleKeys.reset_password_sub_header, TextType.bodyMedium),
        SizedBox(height: AppSpacing.xxl),
      ],
    );
  }
}

////

////

/// 🔁 [_ResetPasswordFooter] — footer with redirect to Sign In

class _ResetPasswordFooter extends StatelessWidget {
  //-----------------------------------------------
  const _ResetPasswordFooter();

  @override
  Widget build(BuildContext context) {
    //
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.l),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextWidget(
            LocaleKeys.reset_password_remember,
            TextType.titleSmall,
          ),
          CustomButton(
            type: ButtonType.text,
            onPressed: () => context.goTo(RoutesNames.signIn),
            label: LocaleKeys.buttons_sign_in,
            isEnabled: true,
            isLoading: false,
          ),
        ],
      ),
    );
  }
}
