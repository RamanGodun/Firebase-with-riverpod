part of 'change_password_page.dart';

class _ChangePasswordInfo extends StatelessWidget {
  const _ChangePasswordInfo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextWidget('If you change your password,', TextType.bodyMedium),
        Text.rich(
          TextSpan(
            text: 'you will be ',
            style: TextStyle(fontSize: 18),
            children: [
              TextSpan(
                text: 'signed out!',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
