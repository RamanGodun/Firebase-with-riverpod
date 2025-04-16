part of 'signin_page.dart';

/// 🧾 [_SigninHeader] — logo and welcome messages
class _SigninHeader extends StatelessWidget {
  const _SigninHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: AppSpacing.xxxl),
        FlutterLogo(size: AppSpacing.massive),
        SizedBox(height: AppSpacing.xxl),
        TextWidget(AppStrings.signInHeader, TextType.headlineSmall),
        TextWidget(AppStrings.signInSubHeader, TextType.bodyMedium),
        SizedBox(height: AppSpacing.m),
      ],
    );
  }
}

/// 🔁 [_SigninFooter] — sign up & reset password actions
class _SigninFooter extends StatelessWidget {
  const _SigninFooter();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const TextWidget(AppStrings.redirectToSignUp, TextType.titleSmall),
            CustomButton(
              type: ButtonType.text,
              onPressed: () => context.goTo(RoutesNames.signup),
              label: AppStrings.signUpButton,
              fontWeight: FontWeight.w600,
              fontSize: 15,
              isEnabled: true,
              isLoading: false,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        CustomButton(
          type: ButtonType.text,
          onPressed: () => context.goTo(RoutesNames.resetPassword),
          label: AppStrings.forgotPassword,
          foregroundColor: AppConstants.errorColor,
          fontWeight: FontWeight.w500,
          isEnabled: true,
          isLoading: false,
        ),
      ],
    );
  }
}
