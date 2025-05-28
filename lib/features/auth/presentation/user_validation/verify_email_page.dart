import 'package:firebase_with_riverpod/core/utils_and_services/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/shared_presentation/constants/app_constants.dart';
import '../../../../core/shared_modules/localization/app_strings.dart';
import '../../../../core/utils_and_services/extensions/context_extensions/_context_extensions.dart';
import '../../../../core/config/firebase/firebase_constants.dart';
import '../../../../core/shared_modules/navigation/routes_names.dart';
import '../../../../core/shared_presentation/widgets/text_widget.dart';
import '../sign_out/sign_out_buttons.dart';
import 'email_verification_provider.dart';

/// 🧼 [VerifyEmailPage] — screen that handles email verification polling
/// Automatically redirects when email gets verified
class VerifyEmailPage extends HookConsumerWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 🚀 Starts the polling logic by reading the notifier
    useEffect(() {
      ref.read(emailVerificationNotifierProvider.notifier);
      return null;
    }, []);

    /// 🔁 Listens to email verification status and handles redirect or error
    ref.listen(emailVerificationNotifierProvider, (prev, next) {
      next.whenOrNull(
        data: (_) => context.goTo(RoutesNames.home),
        // error: (e, _) => context.showErrorDialog(handleException(e)),
      );
    });

    return const Scaffold(body: _VerifyEmailBody());
  }
}

/// 📦 [_VerifyEmailBody] — main UI container with info & cancel
class _VerifyEmailBody extends StatelessWidget {
  const _VerifyEmailBody();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppConstants.white.withOpacity(
            context.isDarkMode ? 0.05 : 0.9,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [_VerifyEmailInfo(), VerifyEmailCancelButton()],
        ).withPaddingAll(AppSpacing.l),
      ),
    );
  }
}

/// ------------------------- Local stateless widgets ------------------------/

/// ℹ️ [_VerifyEmailInfo] — shows instructions about checking inbox / spam
class _VerifyEmailInfo extends StatelessWidget {
  const _VerifyEmailInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextWidget(
          AppStrings.verifyEmailTitle,
          TextType.headlineMedium,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: AppSpacing.m),
        const TextWidget(AppStrings.verifyEmailSent, TextType.bodyMedium),
        const SizedBox(height: AppSpacing.xs),
        TextWidget(
          fbAuth.currentUser?.email ?? AppStrings.unknownEmail,
          TextType.titleMedium,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: AppSpacing.m),
        const TextWidget(AppStrings.verifyEmailNotFound, TextType.bodySmall),
        const SizedBox(height: AppSpacing.xs),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: AppStrings.verifyEmailCheckPrefix,
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: 16,
              color: context.colorScheme.onSurface,
            ),
            children: const [
              TextSpan(
                text: AppStrings.verifyEmailSpam,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: AppStrings.verifyEmailCheckSuffix),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s),
        const TextWidget(
          AppStrings.or,
          TextType.error,
          color: AppConstants.errorColor,
        ),
        const SizedBox(height: AppSpacing.xs),
        const TextWidget(
          AppStrings.verifyEmailEnsureCorrect,
          TextType.bodySmall,
        ),
        const SizedBox(height: AppSpacing.xxxl),
      ],
    );
  }
}
