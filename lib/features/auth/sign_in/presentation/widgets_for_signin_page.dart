part of 'signin_page.dart';

/// 🧾 [_SigninHeader] — logo and welcome messages

class _SigninHeader extends StatelessWidget {
  ///---------------------------------------
  const _SigninHeader();
  //

  @override
  Widget build(BuildContext context) {
    //
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: AppSpacing.huge),
        FlutterLogo(size: AppSpacing.massive),
        SizedBox(height: AppSpacing.xxl),
        TextWidget(LocaleKeys.sign_in_header, TextType.headlineSmall),
        TextWidget(LocaleKeys.sign_in_sub_header, TextType.bodyMedium),
        SizedBox(height: AppSpacing.xxxm),
      ],
    );
  }
}

////

////

/// 🔁 [_SigninFooter] — sign up & reset password actions

class _SigninFooter extends StatelessWidget {
  ///---------------------------------------
  const _SigninFooter();
  //

  @override
  Widget build(BuildContext context) {
    //
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const TextWidget(
              LocaleKeys.buttons_redirect_to_sign_up,
              TextType.titleSmall,
            ),
            CustomButton(
              type: ButtonType.text,
              onPressed: () => context.goTo(RoutesNames.signUp),
              label: LocaleKeys.buttons_sign_up,
              fontWeight: FontWeight.w600,
              fontSize: 15,
              isEnabled: true,
              isLoading: false,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xxs),
        CustomButton(
          type: ButtonType.text,
          onPressed: () => context.goTo(RoutesNames.resetPassword),
          label: LocaleKeys.sign_in_forgot_password,
          foregroundColor: AppColors.forErrors,
          fontWeight: FontWeight.w500,
          isEnabled: true,
          isLoading: false,
        ),
      ],
    );
  }
}
