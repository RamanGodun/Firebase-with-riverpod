part of 'signin_page.dart';

class _SigninHeader extends StatelessWidget {
  const _SigninHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FlutterLogo(size: 120),
        SizedBox(height: AppSpacing.m),
        TextWidget('Welcome Back!', TextType.headlineSmall),
        TextWidget('Please sign in to continue.', TextType.bodyMedium),
        // SizedBox(height: AppSpacing.l),
      ],
    );
  }
}

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
            const TextWidget('Not a member?   ', TextType.titleSmall),
            CustomButton(
              type: ButtonType.text,
              onPressed: () => context.goTo(RoutesNames.signup),
              label: 'Sign Up!',
              fontWeight: FontWeight.w600,
              fontSize: 15,
              isEnabled: true,
              isLoading: false,
            ),
          ],
        ),

        CustomButton(
          type: ButtonType.text,
          onPressed: () => context.goTo(RoutesNames.resetPassword),
          label: 'Forgot Password?',
          foregroundColor: Colors.redAccent,
          fontWeight: FontWeight.w500,
          isEnabled: true,
          isLoading: false,
        ),
      ],
    );
  }
}
