part of 'reauthenticate_page.dart';

class _ReauthenticateInfo extends StatelessWidget {
  const _ReauthenticateInfo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextWidget('Reauthentication', TextType.headlineMedium),
        TextWidget(
          'This is a security-sensitive operation, you must have recently signed in!',
          TextType.titleSmall,
          isTextOnFewStrings: true,
        ),
      ],
    );
  }
}
