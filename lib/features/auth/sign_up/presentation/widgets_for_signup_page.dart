part of 'signup_page.dart';

/// 🧾 [_SignupHeader] — logo and welcome message

class _SignupHeader extends StatelessWidget {
  const _SignupHeader();
  //-------------------

  @override
  Widget build(BuildContext context) {
    //
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: AppSpacing.xxl),
        FlutterLogo(size: AppSpacing.massive),
        SizedBox(height: AppSpacing.xxxm),
        TextWidget(LocaleKeys.pages_sign_up, TextType.headlineSmall),
        TextWidget(LocaleKeys.sign_up_sub_header, TextType.bodyMedium),
        SizedBox(height: AppSpacing.l),
      ],
    );
  }
}

////

////

/// 🔁 [_SignupFooter] — sign in redirect
class _SignupFooter extends StatelessWidget {
  const _SignupFooter();
  //-------------------

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
              LocaleKeys.buttons_redirect_to_sign_in,
              TextType.titleSmall,
            ),
            CustomButton(
              type: ButtonType.text,
              onPressed: () => context.goTo(RoutesNames.signIn),
              label: LocaleKeys.buttons_sign_in,
              fontWeight: FontWeight.w600,
              fontSize: 15,
              isEnabled: true,
              isLoading: false,
            ),
          ],
        ),
      ],
    );
  }
}
