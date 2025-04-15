part of 'verify_email_page.dart';

class _VerifyEmailInfo extends StatelessWidget {
  const _VerifyEmailInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextWidget(
          'Verification email has been sent to',
          TextType.bodyMedium,
        ),
        TextWidget(
          fbAuth.currentUser?.email ?? 'Unknown',
          TextType.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.s),
        const TextWidget(
          'If you cannot find verification email,',
          TextType.bodyMedium,
        ),
        RichText(
          text: TextSpan(
            text: 'Please check ',
            style: DefaultTextStyle.of(context).style.copyWith(fontSize: 18),
            children: const [
              TextSpan(
                text: 'SPAM',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: ' folder.'),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s),
        const TextWidget('Ensure your email is correct.', TextType.bodyMedium),
      ],
    );
  }
}

class _VerifyEmailCancelButton extends ConsumerWidget {
  final Timer? timer;

  const _VerifyEmailCancelButton({required this.timer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomButton(
      type: ButtonType.filled,
      onPressed: () async {
        try {
          await ref.read(authRepositoryProvider).signout();
          timer?.cancel();
        } on CustomError catch (e) {
          if (!context.mounted) return;
          ErrorHandling.showErrorDialog(context, e);
        }
      },
      label: 'CANCEL',
      isLoading: false,
      isEnabled: true,
    );
  }
}
