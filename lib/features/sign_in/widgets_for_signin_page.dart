part of 'signin_page.dart';

class _SigninHeader extends StatelessWidget {
  const _SigninHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [FlutterLogo(size: 150), SizedBox(height: AppSpacing.m)],
    );
  }
}

class _SigninFooter extends StatelessWidget {
  const _SigninFooter();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSpacing.l),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextWidget('Not a member? ', TextType.titleSmall),
            CustomButton(
              type: ButtonType.text,
              onPressed: () => context.goTo(RoutesNames.signup),
              label: 'Sign Up!',
              isEnabled: true,
              isLoading: false,
            ),
          ],
        ),
        CustomButton(
          type: ButtonType.text,
          onPressed: () => context.goTo(RoutesNames.resetPassword),
          label: 'Forgot Password?',
          foregroundColor: Colors.red,
          isEnabled: true,
          isLoading: false,
        ),
      ],
    );
  }
}
