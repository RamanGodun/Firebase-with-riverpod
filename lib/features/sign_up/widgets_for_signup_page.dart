part of 'signup_page.dart';

class _SignupHeader extends StatelessWidget {
  const _SignupHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FlutterLogo(size: 120),
        SizedBox(height: AppSpacing.m),
        TextWidget('Join Us!', TextType.headlineSmall),
        TextWidget('Create an account to get started.', TextType.bodyMedium),
      ],
    );
  }
}

class _SignupFooter extends StatelessWidget {
  const _SignupFooter();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const TextWidget('Already have an account?  ', TextType.titleSmall),
            CustomButton(
              type: ButtonType.text,
              onPressed: () => context.goTo(RoutesNames.signin),
              label: 'Sign In!',
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
