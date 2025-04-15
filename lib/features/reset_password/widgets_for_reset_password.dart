part of 'reset_password_page.dart';

class _ResetPasswordHeader extends StatelessWidget {
  const _ResetPasswordHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: AppSpacing.huge),
        FlutterLogo(size: AppSpacing.huge),
        SizedBox(height: AppSpacing.m),
        TextWidget('Reset your password', TextType.headlineSmall),
        TextWidget(
          'We will send you an email to reset it.',
          TextType.bodyMedium,
        ),
      ],
    );
  }
}

class _ResetPasswordFooter extends StatelessWidget {
  const _ResetPasswordFooter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.l),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextWidget('Remember password? ', TextType.titleSmall),
          CustomButton(
            type: ButtonType.text,
            onPressed: () => context.goTo(RoutesNames.signin),
            label: 'Sign In!',
            isEnabled: true,
            isLoading: false,
          ),
        ],
      ),
    );
  }
}
