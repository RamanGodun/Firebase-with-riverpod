part of 'change_password_page.dart';

/// ℹ️ Info section for [ChangePasswordPage]
class _ChangePasswordInfo extends StatelessWidget {
  const _ChangePasswordInfo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextWidget(AppStrings.passwordChangeTitle, TextType.headlineMedium),
        SizedBox(height: AppSpacing.s),
        TextWidget(AppStrings.passwordChangeWarning, TextType.bodyMedium),
        Text.rich(
          TextSpan(
            text: AppStrings.passwordChangePrefix,
            style: TextStyle(fontSize: 18),
            children: [
              TextSpan(
                text: AppStrings.passwordChangeSignedOut,
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

        SizedBox(height: AppSpacing.s),
      ],
    );
  }
}
