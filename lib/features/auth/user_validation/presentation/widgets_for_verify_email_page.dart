part of 'user_validation_page.dart';

/// ℹ️ [_VerifyEmailInfo] — shows instructions about checking inbox / spam

class _VerifyEmailInfo extends StatelessWidget {
  ///------------------------------------------
  const _VerifyEmailInfo();
  //

  @override
  Widget build(BuildContext context) {
    //
    return Column(
      children: [
        const TextWidget(
          LocaleKeys.pages_verify_email,
          TextType.titleMedium,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: AppSpacing.xxxm),
        const TextWidget(LocaleKeys.verify_email_sent, TextType.bodyMedium),
        const SizedBox(height: AppSpacing.xxs),
        TextWidget(
          fbAuth.currentUser?.email ?? LocaleKeys.verify_email_unknown,
          TextType.titleSmall,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: AppSpacing.xxxm),
        const TextWidget(LocaleKeys.verify_email_not_found, TextType.bodySmall),
        const SizedBox(height: AppSpacing.xxs),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: LocaleKeys.verify_email_check_prefix.tr(),
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: 16,
              color: context.colorScheme.onSurface,
            ),
            children: [
              TextSpan(
                text: LocaleKeys.verify_email_spam.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: LocaleKeys.verify_email_check_suffix.tr()),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xxxs),
        const TextWidget(
          LocaleKeys.verify_email_or,
          TextType.error,
          color: AppColors.forErrors,
        ),
        const SizedBox(height: AppSpacing.xxs),
        const TextWidget(
          LocaleKeys.verify_email_ensure_correct,
          TextType.bodySmall,
        ),
        const SizedBox(height: AppSpacing.xxxl),
      ],
    );
  }
}
