part of 'reauth_page.dart';

/// ℹ️ [_ReauthenticateInfo] — informative section about re-authentication requirement

class _ReauthenticateInfo extends StatelessWidget {
  ///---------------------------------------------
  const _ReauthenticateInfo();
  //

  @override
  Widget build(BuildContext context) {
    //
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: AppSpacing.massive),
        TextWidget(LocaleKeys.reauth_label, TextType.headlineMedium),
        TextWidget(
          LocaleKeys.reauth_description,
          TextType.titleSmall,
          isTextOnFewStrings: true,
        ),
        SizedBox(height: AppSpacing.xl),
      ],
    );
  }
}

////

////

/// 🔁 [_ReAuthFooter] — sign in redirect
class _ReAuthFooter extends ConsumerWidget {
  ///--------------------------------------
  const _ReAuthFooter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    return const Column(
      children: [
        SizedBox(height: AppSpacing.xl),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextWidget(LocaleKeys.reauth_redirect_note, TextType.titleSmall),
            SignOutButton(),
            TextWidget(LocaleKeys.reauth_page, TextType.titleSmall),
          ],
        ),
      ],
    );
  }
}
